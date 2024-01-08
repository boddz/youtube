require 'test/unit'

require_relative '../lib/youtube-data'
require_relative 'mocks'


#https://ruby-doc.org/stdlib-3.0.2/libdoc/test-unit/rdoc/Test/Unit/Assertions.html


class TestExtractor < Test::Unit::TestCase
  def setup
    @mock_session = Mocks::MockSession.new(nil)
    # Copy valid video html from file into the mock sessions `get` mock response which acts the same as normal session.
    @mock_session.set_res_body(File.read('./data/raw_video.html'))
    # Specify mock session to use and replace actual session with `opts[:mock_session]`.
    @extractor = Youtube::DataExtractor.new('FtutLA63Cp8', {:mock_session => @mock_session})
  end

  def test_response_invalid_path
    assert_raise(Youtube::InvalidPathError) do
      @extractor.get_raw(nil)
    end
    assert_raise(Youtube::InvalidPathError) do
      @extractor.get_raw("invalid/path")
    end
  end

  def test_response_valid
    res = @extractor.get_raw('/')
    assert_instance_of(Mocks::MockResponse, res)
  end
end
