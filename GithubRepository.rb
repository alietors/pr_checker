class GithubRepository 
  attr_accessor :url, :pullRequestList
  
  def initialize()
    @url = ''
    self.initPullRequestDownloader();
  end
  
  def initialize(url)
    @url = url
    self.initPullRequestDownloader();
  end
  
  def initPullRequestDownloader
    @pullRequestDownloader = new PullRequestDownloader
  end
  
  def downloadPullRequests()
    self.pullRequestList = @pullRequestDownloader.download(@url)
  end
end