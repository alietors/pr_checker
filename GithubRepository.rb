require_relative 'PullRequestDownloader'

class GithubRepository 
  attr_accessor :owner, :repository, :pullRequestList, :pullRequestDownloader
  
  def initialize
    @url = ''
    @pullRequestDownloader = PullRequestDownloader.new
  end
  
  def setOwner(owner)
    @owner = owner
  end
  
  def setRepository(repository)
    @repository = repository
  end
  
  def downloadPullRequests()
    self.pullRequestList = @pullRequestDownloader.download(@owner, @repository)
  end
end