# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'json'

require_relative 'youtube/version'
require_relative 'youtube/extractor'
require_relative 'youtube/thumbnail'
require_relative 'youtube/video'

module Youtube

  class InitExtractorError < RuntimeError
  end

  class InvalidVideoIDError < StandardError
  end

  class InvalidPathError < StandardError
  end

  class Error < StandardError; end

end
