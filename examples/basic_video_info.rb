#!/usr/bin/env ruby
# frozen_string_literal: true

require 'youtube-data'

extractor = Youtube::DataExtractor.new('k598b_JcQOU')  # Extracts, cache, and then parse data.
video = Youtube::Video.new(extractor)  # Interface for the video using extractor data.

# Video title, uploader, views and the description.
puts video.title
puts "Uploaded by: #{video.uploader} | View count: #{video.views}"
puts video.description
