require_relative 'PullRequest'
require_relative 'GitHubUser'

class PullRequestFormatter
  
  def initialize
  end
  
  def formatPullRequest(body)
    pullRequestList = []
    body.each  do |pullRequest|
      pullRequestToInsert = PullRequest.new
      creator = GitHubUser.new
      reviewer = GitHubUser.new
      creator.name = pullRequest['user']['login'];
      reviewer.name = pullRequest['assignee']['login']
      pullRequestToInsert.creator = creator
      pullRequestToInsert.reviewer = reviewer
      pullRequestToInsert.openTimestamp = pullRequest['created_at']
      pullRequestToInsert.updatedTimestamp = pullRequest['updated_at']
      pullRequestList << pullRequestToInsert
    end
    return pullRequestList
  end
  
end