require_relative 'wrapper/RestWrapper'
require_relative 'formatter/PullRequestFormatter'
require_relative 'formatter/UserFormatter'

class PullRequestDownloader
  
  BASE_URL = 'https://api.github.com/'
  
  def initialize(pullRequestFormatter, userFormatter, restWrapper)
    @pullRequestFormatter = pullRequestFormatter
    @userFormatter = userFormatter
    @restWrapper = restWrapper
  end
  
  def download(owner, repository)
    incompletePullRequests = self.downloadPullRequests(owner, repository)
    return self.updatePullRequests(incompletePullRequests, owner)
  end
  
  def downloadPullRequests(owner, repository)
    url = self.buildPullUrl(owner, repository)
    response = @restWrapper.get(url)
    return @pullRequestFormatter.format(response.body)
  end
  
  def buildPullUrl(owner, repository)
    BASE_URL+'repos/'+owner+'/'+repository+'/pulls'
  end
  
  def updatePullRequests(incompletePullRequest, owner)
    usersInfo = Hash.new
    pullRequests = []
    
    incompletePullRequest.each do | pullRequest |   
      user = self.getUserInformation(pullRequest.creator.name, usersInfo)
      pullRequest.creator.email = user.email
      
      user = self.getUserInformation(pullRequest.reviewer.name, usersInfo)
      pullRequest.reviewer.email = user.email
      
      pullRequest.repoOwner = owner
      
      pullRequests << pullRequest
    end
    return pullRequests
  end
  
  def getUserInformation(userName, usersInfo)
    if (!usersInfo.include? userName)
        user = self.downloadUserInformation(userName)
        usersInfo[user.name] = user
    end
    if usersInfo[userName].nil?
      return User.new
    end
    return usersInfo[userName]
  end
  
  def downloadUserInformation(userName)
    url = self.buildUserUrl(userName)
    response = @restWrapper.get(url)
    return @userFormatter.format(response.body)
  end
  
  def buildUserUrl(user)
    BASE_URL+'users/'+user
  end
  
end