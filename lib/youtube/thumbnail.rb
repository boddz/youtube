# frozen_string_literal: true

module Youtube

  # Used for extracting thumbnails/ images data and bytes stored on `i.ytimg.com`.
  #
  # @param extractor [Youtube::DataExtractor] The extractor to use when getting initial required video data.
  #
  class Thumbnail
    BASEHOST = URI('https://i.ytimg.com/')

    def initialize(extractor, opts = {})
      @extractor = extractor

      # The session to use for the extractor allows information to persist during requests/session.
      @session = Net::HTTP.start(BASEHOST.hostname, {'use_ssl': true})
      if opts.include?(:mock_session)
        @session = opts[:mock_session]
      end

      @thumb_json_array = jump_to_in_json
      @thumb_default_json = @thumb_json_array[0]
    end

    # An array of thumbnail(s) json data (stored as a hash).
    #
    # @return [Array] The array of hashes about the thumbnail(s).
    # @yield [Array] The same as return, but yields to block if given.
    #
    def thumbnails_json
      return @thumb_json_array unless block_given?
      yield @thumb_json_array
    end

    # The json data for the default thumbnail (stored as a hash).
    #
    # @return [Hash] The hash form of the default thumbnail's json.
    # @yield [Hash] The same as return, but yields to block if given.
    #
    def default_json
      return @thumb_default_json unless block_given?
      yield @thumb_default_json
    end

    # Destination URL to default thumbnail file on the server which is returned/ yielded as a `URI::HTTPS` instance.
    def default_url
      return URI(@thumb_default_json['url']) unless block_given?
      yield URI(@thumb_default_json['url'])
    end

    # The file name for the default thumbnail which is returned/ yielded as `String` instance.
    def default_filename
      filename = default_url.path[/[A-Za-z0-9]+\.[A-Za-z0-9]+/]
      return filename unless block_given?
      yield filename
    end

    # The bytes contained in the default thumbnail file stored on the server returned/ yielded as `String` instance.
    def default_bytes
      res = get_raw(default_url.path)
      return res.body unless block_given?
      yield res.body
    end

    # Send a simple get request using the thumbnail session. This should be how the module sends all further requests
    # to the `i.ytimg.com` hostname outside of this class also.
    #
    # @param path [String] Any valid path on the server, prefixed with `/`.
    # @return [Net::HTTPResponse] The untouched response sent back from the request.
    # @yield [Net::HTTPResponse] Same as return but yielded to block.
    #
    def get_raw(path)
      res = get_request_path(path)
      return res unless block_given?
      yield res
    end

    # Use `get_raw` method it's the same, but is shorter and can yield.
    private def get_request_path(path)
      if path.class != "".class
        raise InvalidPathError, 'Path on server must be type `String\''
      end
      if path.empty? == false and path[0] != "/"
        raise InvalidPathError, 'Path must be prefixed with `/\''
      end
      return @session.get(path)
    end

    private def jump_to_in_json
      return @extractor.video_json_untouched['microformat']['playerMicroformatRenderer']['thumbnail']['thumbnails']
    end

  end

end
