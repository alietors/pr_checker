require_relative '../dto/pull_request'
require_relative '../dto/user'

class PullRequestFormatter
  def format(**body)
    pull_request_list = []
    body['body'].each do |pull_request|
      reviewer = build_reviewer(pull_request)
      creator = build_creator(pull_request)
      pr_to_insert = build_pull_request(creator, reviewer, pull_request)
      pull_request_list << pr_to_insert
    end
    pull_request_list
  end

  private def build_creator(**pr)
    creator = User.new
    creator.name = pr['pull_request']['user']['login']
    creator
  end

  private def build_reviewer(**pr)
    reviewer = User.new
    reviewer.name =
      pr['pull_request']['assignee']['login'] unless
        pr['pull_request']['assignee'].nil?
    reviewer
  end

  private def build_pull_request(**pr)
    pull_request_to_insert = PullRequest.new
    pull_request_to_insert.creator = pr['creator']
    pull_request_to_insert.reviewer = pr['reviewer']
    pull_request_to_insert.url = pr['pull_request']['html_url']
    pull_request_to_insert.open_timestamp = pr['pull_request']['created_at']
    pull_request_to_insert.updated_timestamp = pr['pull_request']['updated_at']
    pull_request_to_insert.repository = pr['pull_request']['head']['repo']['name']
    pull_request_to_insert.issue_number = pr['pull_request']['number']

    pull_request_to_insert
  end
end
