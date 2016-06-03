class MessageFormatter
  def initialize(imageUrl)
    @imageUrl = imageUrl
  end
  def formatMessage(pullRequest)
    message = self.generateImage + self.generateMessage(pullRequest)
    return message
  end
  
  def generateMessage(pullRequest)
    return "@"+pullRequest.reviewer.name+ " you have a waiting PR from @"+pullRequest.creator.name+"\n"+pullRequest.url
  end
  
  def generateImage
    if(@imageUrl.nil? || @imageUrl.empty?)
      return ''
    end
    return "![Image](#{@imageUrl})\n"
  end
end