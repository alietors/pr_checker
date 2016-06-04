class MessageFormatter
  def initialize(imageUrl)
    @imageUrl = imageUrl
  end
  def formatMessage(pullRequest)
    message = generateImage + generateMessage(pullRequest)
    return message
  end
  
  private def generateMessage(pullRequest)
    return "@#{pullRequest.reviewer.name} you have a PR waiting from @#{pullRequest.creator.name}\n#{pullRequest.url}"
  end
  
  private def generateImage
    if(@imageUrl.nil? || @imageUrl.empty?)
      return ''
    end
    return "![Image](#{@imageUrl})\n"
  end
end