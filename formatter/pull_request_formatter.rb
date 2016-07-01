require_relative '../dto/pull_request'
require_relative '../dto/user'

class PullRequestFormatter
  def format(body)
    pull_request_list = []
    body.each do |pull_request|
      reviewer = build_reviewer(pull_request)
      creator = build_creator(pull_request)
      pr_to_insert = build_pull_request(creator, reviewer, pull_request)
      pull_request_list << pr_to_insert
    end
    pull_request_list
  end

  private def build_creator(pull_request)
    creator = User.new
    creator.name = pull_request['user']['login']
    creator
  end

  private def build_reviewer(pull_request)
    reviewer = User.new
    reviewer.name =
      pull_request['assignee']['login'] unless pull_request['assignee'].nil?
    reviewer
  end

  private def build_pull_request(creator, reviewer, pull_request)
    pull_request_to_insert = PullRequest.new
    pull_request_to_insert.creator = creator
    pull_request_to_insert.reviewer = reviewer
    pull_request_to_insert.url = pull_request['html_url']
    pull_request_to_insert.open_timestamp = pull_request['created_at']
    pull_request_to_insert.updated_timestamp = pull_request['updated_at']
    pull_request_to_insert.repository = pull_request['head']['repo']['name']
    pull_request_to_insert.issue_number = pull_request['number']

    pull_request_to_insert
  end
end
