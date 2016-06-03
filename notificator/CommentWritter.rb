class CommentWritter
  
  BASE_URL = 'https://api.github.com/'
  
  def initialize(messageFormatter, restWrapper, dayLimitNumber)
    @messageFormatter = messageFormatter
    @restWrapper = restWrapper
    @dayLimitNumber = dayLimitNumber
  end
  
  def sendMessage(pullRequests)
    pullRequests.each do | pullRequest |
      if(self.requireMessage(pullRequest))
        message = self.formatMessage(pullRequest)
        self.send(message, pullRequest)
      end
    end
  end
  
  def requireMessage(pullRequest)
    return self.isPullRequestOld(pullRequest) && self.hasAssignee(pullRequest)
  end
    
  def isPullRequestOld(pullRequest)
    redLineTime = DateTime.now - @dayLimitNumber
    prUpdated = DateTime.rfc3339(pullRequest.updatedTimestamp)
    return (redLineTime <=> prUpdated) == 1
  end
  
  def hasAssignee(pullRequest)
    return !pullRequest.reviewer.name.empty?
  end
  
  def formatMessage(pullRequest)
    @messageFormatter.formatMessage(pullRequest)
  end
  
  def send(message, pullRequest)
    url = self.getCommentUrl(pullRequest.repoOwner, pullRequest.repository, pullRequest.issueNumber)
    @restWrapper.post(url, message)
  end
  
  def getCommentUrl(owner, repo, issueNumber)
    return BASE_URL+'repos/'+owner+'/'+repo+'/issues/'+issueNumber.to_s+'/comments'
  end
end