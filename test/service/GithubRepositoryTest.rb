require 'minitest/autorun'
require 'minitest/mock'

require_relative '../../service/GithubRepository'

class GithubRepositoryTest < Minitest::Test

  def setup
    @pullRequestDownloaderMock = MiniTest::Mock.new
    @githubRepository = GithubRepository.new(@pullRequestDownloaderMock)
  end
  
  def test_no_pull_request
    owner = "owner"
    repository = "repo"
    @githubRepository.setOwner(owner)
    @githubRepository.setRepository(repository)
    
    @pullRequestDownloaderMock.expect(:download, '', [owner, repository])
    
    repositoryList = @githubRepository.downloadPullRequests()
    assert_empty(repositoryList)
  end

end