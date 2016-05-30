class PRChecker
  attr_accessor :githubRepository
  
  def initialize()
    @githubRepository = new GithubRepository
  end
  
  def initialize(githubRepository)
    @githubRepository = githubRepository
  end
  
  def setUrl(url)
    @githubRepository.setUrl(url)
  end
  
  def getPullRequestList
    @githubRepository.getPullRequestList()
  end
  
end