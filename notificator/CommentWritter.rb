class CommentWritter
  
  BASE_URL = 'https://api.github.com/'
  
  def initialize(restWrapper)
    @restWrapper = restWrapper
  end
  
  def send(message, pullRequest)
    url = getCommentUrl(pullRequest.repoOwner, pullRequest.repository, pullRequest.issueNumber)
    @restWrapper.post(url, message)
  end
  
  private def getCommentUrl(owner, repo, issueNumber)
    return BASE_URL+'repos/'+owner+'/'+repo+'/issues/'+issueNumber.to_s+'/comments'
  end
end