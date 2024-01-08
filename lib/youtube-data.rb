# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'json'

require_relative 'youtube/version'
require_relative 'youtube/extractor'
require_relative 'youtube/thumbnail'

module Youtube
  class Error < StandardError; end
end
