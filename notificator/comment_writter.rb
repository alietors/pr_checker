class CommentWritter
  BASE_URL = 'https://api.github.com/'.freeze

  def initialize(rest_wrapper)
    @rest_wrapper = rest_wrapper
  end

  def send(message, pull_request)
    url = get_comment_url(
      pull_request.repo_owner,
      pull_request.repository,
      pull_request.issue_number
    )
    @rest_wrapper.post(url, message)
  end

  private def get_comment_url(owner, repo, issue_number)
    BASE_URL + "repos/#{owner}/#{repo}/issues/#{issue_number}/comments"
  end
end
