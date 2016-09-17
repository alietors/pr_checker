require 'minitest/autorun'
require 'minitest/mock'

require_relative '../../formatter/message_formatter'
require_relative '../../dto/user'
require_relative '../../dto/pull_request'

class MessageFormatterTest < Minitest::Test
  def setup
  end

  def test_format_message
    @message_formatter = MessageFormatter.new(url: '')
    pull_request = configure_pull_request
    expected = format_message_expected(pull_request: pull_request)

    message = @message_formatter.format_message(pull_request: pull_request)

    assert_equal(expected, message)
  end

  def test_format_message_with_image
    image_url = 'url'
    @message_formatter = MessageFormatter.new(url: image_url)
    pull_request = configure_pull_request
    expected = format_message_expected(pull_request: pull_request, image: image_url)

    message = @message_formatter.format_message(pull_request: pull_request)

    assert_equal(expected, message)
  end

  private def configure_pull_request
    pull_request = PullRequest.new
    pull_request.creator = User.new(name: 'creator', email: '')
    pull_request.reviewer = User.new(name: 'reviewer', email: '')
    pull_request.url = 'http://test.com/pull'

    pull_request
  end

  private def format_message_expected(pull_request:, image: '')
    expected = ''
    expected = "![Image](#{image})\n" unless image.empty?
    expected + "@#{pull_request.reviewer.name} you have a PR waiting from "\
    "@#{pull_request.creator.name}\n#{pull_request.url}"
  end
end
