class MessageFormatter
  def formatMessage(pullRequest)
    message = self.generateImage + self.generateMessage(pullRequest)
    return message
  end
  
  def generateMessage(pullRequest)
    return "@"+pullRequest.reviewer.name+ " you have a waiting PR from @"+pullRequest.creator.name+"\n"+pullRequest.url
  end
  
  def generateImage
    return "![Crazy Monkey](https://media.giphy.com/media/kLLvH1EOtCwQ8/giphy.gif)\n"
  end
end