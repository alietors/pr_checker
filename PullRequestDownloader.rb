require 'unirest'
require_relative 'PullRequestFormatter'

class PullRequestDownloader
  
  def initialize
    @baseUrl = 'https://api.github.com/repos/'
    @pullRequestFormatter = PullRequestFormatter.new
  end
  
  def download(owner, repository)
    url = self.buildPullUrl(owner, repository)
    response = Unirest.get(url)
    return @pullRequestFormatter.formatPullRequest(response.body)
  end
  
  def buildPullUrl(owner, repository)
    @baseUrl+owner+'/'+repository+'/pulls'
  end
end