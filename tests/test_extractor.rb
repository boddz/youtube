require 'test/unit'

require_relative '../lib/youtube-data'
require_relative 'mocks'


class TestExtractor < Test::Unit::TestCase
  def setup
    @mock_session = Mocks::MockSession.new(nil)
    # Copy valid video html from file into the mock sessions `get` mock response which acts the same as normal session.
    @mock_session.set_res_body(File.read('./data/raw_video.html'))
    # Specify mock session to use and replace actual session with `opts[:mock_session]`.
    @extractor = Youtube::DataExtractor.new('FtutLA63Cp8', {:mock_session => @mock_session})
  end

  def test_video_uri
    assert_equal(@extractor.video_uri, URI('https://www.youtube.com/watch?v=FtutLA63Cp8'))
  end

  def test_player_uri
    assert_instance_of(URI::HTTPS, @extractor.player_uri)
    assert_true(@extractor.player_uri.to_s.end_with?('base.js'))
  end

  def test_response_invalid_path
    assert_raise(Youtube::InvalidPathError) do
      @extractor.get_raw(nil)
    end
    assert_raise(Youtube::InvalidPathError) do
      @extractor.get_raw("invalid/path")
    end
  end

  def test_response_valid_mock_returned
    res = @extractor.get_raw('/')
    assert_instance_of(Mocks::MockResponse, res)
  end

  def test_not_raise_untouched_json_data
    @extractor.video_json_untouched  # Valid json hash returned.
  end

end
