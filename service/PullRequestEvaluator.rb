class PullRequestEvaluator
  
  def initialize(messageWritter, messageFormatter, dayLimitNumber)
    @messageFormatter = messageFormatter
    @dayLimitNumber = dayLimitNumber
    @messageWritter = messageWritter
  end
  
  def evaluatePullRequests(pullRequests)
    pullRequests.each do | pullRequest |
      if(requireMessage(pullRequest))
        message = formatMessage(pullRequest)
        @messageWritter.send(message, pullRequest)
      end
    end
  end
  
  private def requireMessage(pullRequest)
    return isOldPullRequest(pullRequest) && hasAssignee(pullRequest)
  end
    
  private def isOldPullRequest(pullRequest)
    redLineTime = DateTime.now - @dayLimitNumber
    prUpdated = DateTime.rfc3339(pullRequest.updatedTimestamp)
    return (redLineTime <=> prUpdated) == 1
  end
  
  private def hasAssignee(pullRequest)
    return !pullRequest.reviewer.name.empty?
  end
  
  private def formatMessage(pullRequest)
    @messageFormatter.formatMessage(pullRequest)
  end
end