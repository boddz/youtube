# frozen_string_literal: true

require 'test/unit'

require_relative '../lib/youtube-data'
require_relative 'mocks'


class TestVideo < Test::Unit::TestCase
  def setup
    @mock_session = Mocks::MockSession.new(nil)
    # Copy valid video html from file into the mock sessions `get` mock response which acts the same as normal session.
    @mock_session.set_res_body(File.read('./data/raw_video.html'))
    # Specify mock session to use and replace actual session with `opts[:mock_session]`.
    @extractor = Youtube::DataExtractor.new('FtutLA63Cp8', {:mock_session => @mock_session})
    @video = Youtube::Video.new(@extractor)
  end

  def test_json
    assert_instance_of(Hash, @video.json)
  end

  def test_thumbnails_array
    assert_instance_of(Array, @video.thumbnails)
    assert_instance_of(Hash, @video.thumbnails[0])
  end

  def test_channel_id
    assert_equal(@video.channel_id, 'UCEJJbhF5Hod0zsupy-26n_g')
  end

  def test_id
    assert_equal(@video.id, 'FtutLA63Cp8')
  end

  def test_title
    assert_equal(@video.title, '【東方】Bad Apple!! ＰＶ【影絵】')
  end

  def test_description
    assert_equal(@video.description, 'sm8628149')
  end

  def test_views
    assert_instance_of(Integer, @video.views)
  end

  def test_author
    assert_equal(@video.author, 'kasidid2')
    assert_equal(@video.uploader, 'kasidid2')
  end

  def test_keywords
    assert_instance_of(Array, @video.keywords)
    assert_equal(@video.keywords.length, 6)
  end

  def test_length_in_seconds
    assert_equal(@video.length_in_seconds, 219)
  end

  def test_is_crawlable
    assert_true(@video.is_crawlable?)
  end

  def test_allow_ratings
    assert_true(@video.allow_ratings?)
  end

  def test_is_live
    assert_false(@video.is_live?)
  end

end
