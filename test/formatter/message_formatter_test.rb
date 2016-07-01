require 'minitest/autorun'
require 'minitest/mock'

require_relative '../../formatter/message_formatter'
require_relative '../../dto/user'
require_relative '../../dto/pull_request'

class MessageFormatterTest < Minitest::Test
  def setup
  end

  def test_format_message
    @message_formatter = MessageFormatter.new('')
    pull_request = configure_pull_request
    expected = format_message_expected(pull_request)

    message = @message_formatter.format_message(pull_request)

    assert_equal(expected, message)
  end

  def test_format_message_with_image
    image_url = 'url'
    @message_formatter = MessageFormatter.new(image_url)
    pull_request = configure_pull_request
    expected = format_message_expected(pull_request, image_url)

    message = @message_formatter.format_message(pull_request)

    assert_equal(expected, message)
  end

  private def configure_pull_request
    pull_request = PullRequest.new
    pull_request.creator = User.new('creator', '')
    pull_request.reviewer = User.new('reviewer', '')
    pull_request.url = 'http://test.com/pull'

    pull_request
  end

  private def format_message_expected(pull_request, image = '')
    expected = ''
    expected = "![Image](#{image})\n" unless image.empty?
    expected + "@#{pull_request.reviewer.name} you have a PR waiting from"\
    "@#{pull_request.creator.name}\n#{pull_request.url}"
  end
end
