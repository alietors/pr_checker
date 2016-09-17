class CommentWriter
  BASE_URL = 'https://api.github.com/'.freeze

  def initialize(rest_wrapper:)
    @rest_wrapper = rest_wrapper
  end

  def send(message:, pull_request:)
    url = get_comment_url(
      owner: pull_request.repo_owner,
      repo: pull_request.repository,
      issue_number: pull_request.issue_number
    )
    @rest_wrapper.post(url: url, message: message)
  end

  private def get_comment_url(owner:, repo:, issue_number:)
    BASE_URL + "repos/#{owner}/#{repo}/issues/#{issue_number}/comments"
  end
end
