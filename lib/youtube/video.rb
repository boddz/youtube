# frozen_string_literal: true

module Youtube

  class Video

    def initialize(extractor, opts = {})
      @extractor = extractor
    end

    # @return [Hash] The section of scraped json that contains video information just as is.
    def json
      @video_info_json = @extractor.video_json_untouched['videoDetails']
      return @video_info_json unless block_given?
      yield @video_info_json
    end

    # @return [Array] An array of different thumbnail image info hashes.
    def thumbnails
      return json['thumbnail']['thumbnails']
    end

    # @return [String] ID of the channel that owns the video.
    def channel_id
      return json['channelId']
    end

    # @return [String] ID of the video.
    def id
      return json['videoId']
    end

    # @return [String] The title of the video.
    def title
      return json['title']
    end

    # @return [String] The video description.
    def description
      return json['shortDescription']
    end

    # @return [Integer] Number of views that the video has.
    def views
      return json['viewCount'].to_i
    end

    # @return [String] The person who uploaded the video.
    def author
      return json['author']
    end

    # Same as `author` method.
    def uploader
      return author
    end

    # @return [Array] An array of keywords relating to the video.
    def keywords
      return json['keywords']
    end

    # @return [Integer] Length of the video in seconds.
    def length_in_seconds
      return json['lengthSeconds'].to_i
    end

    # @return [TrueClass, FalseClass] Whether or not the video is crawlable in the player.
    def is_crawlable?
      return json['isCrawlable']
    end

    # @return [TrueClass, FalseClass] Whether or not the video displays likes.
    def allow_ratings?
      return json['allowRatings']
    end

    # @return [TrueClass, FalseClass] Whether or not the video is a live stream.
    def is_live?
      return json['isLiveContent']
    end

  end

end
