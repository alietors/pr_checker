require_relative '../wrapper/RestWrapper'
require_relative '../formatter/PullRequestFormatter'
require_relative '../formatter/UserFormatter'

class PullRequestDownloader
  
  BASE_URL = 'https://api.github.com/'
  
  def initialize(pullRequestFormatter, userFormatter, restWrapper)
    @pullRequestFormatter = pullRequestFormatter
    @userFormatter = userFormatter
    @restWrapper = restWrapper
  end
  
  def download(owner, repository)
    incompletePullRequests = downloadPullRequests(owner, repository)
    return updatePullRequests(incompletePullRequests, owner)
  end
  
  private def downloadPullRequests(owner, repository)
    url = buildPullUrl(owner, repository)
    response = @restWrapper.get(url)
    return @pullRequestFormatter.format(response.body)
  end
  
  private def buildPullUrl(owner, repository)
    BASE_URL+'repos/'+owner+'/'+repository+'/pulls'
  end
  
  private def updatePullRequests(incompletePullRequest, owner)
    usersInfo = Hash.new
    pullRequests = []
    
    incompletePullRequest.each do | pullRequest |   
      user = getUserInformation(pullRequest.creator.name, usersInfo)
      pullRequest.creator.email = user.email
      
      user = getUserInformation(pullRequest.reviewer.name, usersInfo)
      pullRequest.reviewer.email = user.email
      
      pullRequest.repoOwner = owner
      
      pullRequests << pullRequest
    end
    return pullRequests
  end
  
  private def getUserInformation(userName, usersInfo)
    if (!usersInfo.include? userName)
        user = downloadUserInformation(userName)
        usersInfo[user.name] = user
    end
    if usersInfo[userName].nil?
      return User.new
    end
    return usersInfo[userName]
  end
  
  private def downloadUserInformation(userName)
    url = buildUserUrl(userName)
    response = @restWrapper.get(url)
    return @userFormatter.format(response.body)
  end
  
  private def buildUserUrl(user)
    BASE_URL+'users/'+user
  end
  
end