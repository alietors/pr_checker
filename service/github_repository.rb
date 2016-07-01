require_relative '../helper/pull_request_downloader'

class GithubRepository
  attr_accessor :owner,
                :repository,
                :pull_request_list,
                :pull_request_downloader

  def initialize(pull_request_downloader)
    @url = ''
    @pull_request_downloader = pull_request_downloader
  end

  def download_pull_requests
    @pull_request_list = @pull_request_downloader.download(@owner, @repository)
  end
end
