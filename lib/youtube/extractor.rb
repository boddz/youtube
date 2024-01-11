# frozen_string_literal: true

module Youtube

  # For extracting the data needed from a video in a native format.
  #
  # @param video_id [String] The video ID in which to scrape data from.
  #
  # Options
  # =======
  #
  #   :mock_session => [MockSession] The mock session to use when testing.
  #
  class DataExtractor

    HOMEPAGE = URI('https://www.youtube.com')

    def initialize(video_id, opts = {})
      @video_id = video_id
      @video_path = "/watch?v=#{@video_id}"

      # The session to use for the extractor allows information to persist during requests/session.
      @session = Net::HTTP.start(HOMEPAGE.hostname, {'use_ssl': true})
      if opts.include?(:mock_session)
        @session = opts[:mock_session]
      end

      # Cache variables for raw data, saves overhead and less requests from the client session.
      # Required requests.
      @video_html = get_raw_html
      # Required non-requests.
      @video_json_raw = find_raw_json_in_html(@video_html)
      @video_player_path = find_player_base_js_path_in_html(@video_html)
    end

    def inspect
      return itself
    end

    # Full url to the video's html page returned/ yielded as a `URI::HTTPS` instance.
    def video_uri
      uri = URI.join(HOMEPAGE, video_path)
      return uri unless block_given?
      yield uri
    end

    # Full url to the `base.js` video player script returned/ yielded as a `URI::HTTPS` instance.
    def player_uri
      uri = URI.join(HOMEPAGE, @video_player_path)
      return uri unless block_given?
      yield uri
    end

    # Send a simple get request using the extractor session. This should be how the module sends all further requests
    # to the `youtube.com` hostname outside of this class also.
    #
    # @param path [String] Any valid path on the server, prefixed with `/`.
    # @return [Net::HTTPResponse] The untouched response sent back from the request.
    # @yield [Net::HTTPResponse] Same as return but yields to block if present.
    #
    def get_raw(path)
      res = get_request_path(path)
      return res unless block_given?
      yield res
    end

    def video_raw_html
      return @video_html unless block_given?
      yield @video_html
    end

    # This is the json data for the video that is not yet been altered in terms of it's underlying structure, and of
    # which is in it's purest form, but has been processed in a way that makes it easy to work with either through a
    # file or a hash that is returned to the caller.
    #
    # @param dump_file [String] File path to write to (don't open if not provided).
    # @param opt [Hash, String] `:pretty` if a dump file is specified, when set to true then format pretty else raw.
    #
    # @return [Hash] A hash representing the untouched json data parsed from the raw json html data of a video.
    # @yield [Hash] Same as return but yields to block if provided.
    #
    def video_json_untouched(dump_file = nil, opt = {:pretty => true})
      parsed_json = JSON.parse(@video_json_raw)

      if dump_file.nil? == false
        File.open("#{dump_file}", 'w') do |json_file|
          if opt.include?(:pretty) and opt[:pretty] == true
            json_file.write(JSON.pretty_generate(parsed_json))
          else
            JSON.dump(parsed_json, io=json_file)
          end
        end
      end

      return parsed_json unless block_given?
      yield parsed_json
    end

    # Path from the homepage to the video's page.
    private def video_path
      if @video_id.length != 11  # 11 is the fixed length of a video ID on youtube.
        raise InvalidVideoIDError, "The video id `#{@video_id}' is not valid (too short)"
      end
      return @video_path
    end

    # Sends a GET request to a specified path on the server using the request handler's session.
    private def get_request_path(path)
      if path.class != "".class
        raise InvalidPathError, 'Path on server must be type `String\''
      end
      if path.empty? == false and path[0] != "/"
        raise InvalidPathError, 'Path must be prefixed with `/\''
      end
      return @session.get(path)
    end

    private def get_raw_html
      return get_request_path(video_path).body
    end

    private def find_raw_json_in_html(html)
      var = html[/ytInitialPlayerResponse.*=.*\{.*\};/]  # Regex match containing var.
      return var[/\{.*\}/]  # From matched var, extract the valid js object.
    end

    private def find_player_base_js_path_in_html(html)
      return html[/([A-Za-z0-9]+(\/[A-Za-z0-9]+)+)_[A-Za-z0-9]+\.[A-Za-z0-9]+\/[A-Za-z0-9]+_[A-Za-z0-9]+\/base\.js/]
    end

  end

end
