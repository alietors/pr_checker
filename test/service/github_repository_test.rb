require 'minitest/autorun'
require 'minitest/mock'

require_relative '../../service/github_repository'

class GithubRepositoryTest < Minitest::Test
  def setup
    @pull_request_downloader_mock = MiniTest::Mock.new
    @github_repository = GithubRepository.new(@pull_request_downloader_mock)
  end

  def test_no_pull_request
    owner = 'owner'
    repository = 'repo'
    @github_repository.owner = owner
    @github_repository.repository = repository

    @pull_request_downloader_mock.expect(:download, '', [owner, repository])

    repository_list = @github_repository.download_pull_requests
    assert_empty(repository_list)
  end
end
