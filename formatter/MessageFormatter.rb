class MessageFormatter
  def formatMessage(pullRequest)
    message = "@"+pullRequest.reviewer.name+ " you have a waiting PR from @"+pullRequest.creator.name+"\n"+pullRequest.url
    return message
  end
end