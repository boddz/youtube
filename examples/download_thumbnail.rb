#!/usr/bin/env ruby
# frozen_string_literal: true

require 'youtube-data'

extractor = Youtube::DataExtractor.new("FtutLA63Cp8")  # Extract, cache, and parse data.
thumbnail = Youtube::Thumbnail.new(extractor)  # Create a new interface for thumbnails.

# Download methods for thumbnails involve sending another seperate request due to them being stored on another server.
thumbnail.download_default

puts "Downloaded default thumbnail: `#{thumbnail.default_filename}`!"  # Default is the first item in thumbnails array.
