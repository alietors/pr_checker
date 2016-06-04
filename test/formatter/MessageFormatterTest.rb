require 'minitest/autorun'
require 'minitest/mock'

require_relative '../../formatter/MessageFormatter'
require_relative '../../dto/User'
require_relative '../../dto/PullRequest'

class MessageFormatterTest < Minitest::Test

  def setup
  end
  
  def test_format_message
    @messageFormatter = MessageFormatter.new('')
    pullRequest = configure_pull_request
    expected = format_message_expected(pullRequest)
    
    message = @messageFormatter.formatMessage(pullRequest)
  
    assert_equal(expected, message)
  end
  
  def test_format_message_with_image
    imageUrl = 'url'
    @messageFormatter = MessageFormatter.new(imageUrl)
    pullRequest = configure_pull_request
    expected = format_message_expected(pullRequest, imageUrl)
    
    message = @messageFormatter.formatMessage(pullRequest)
  
    assert_equal(expected, message)
  end
  
  private def configure_pull_request
    pullRequest = PullRequest.new
    pullRequest.creator = User.new('creator', '')
    pullRequest.reviewer = User.new('reviewer', '')
    pullRequest.url = "http://test.com/pull"
    
    return pullRequest
  end
  
  private def format_message_expected(pullRequest, image = '')
    expected = ''
    if(!image.empty?)
      expected = "![Image](#{image})\n"
    end
    expected += "@#{pullRequest.reviewer.name} you have a PR waiting from @#{pullRequest.creator.name}\n#{pullRequest.url}"
  end

end