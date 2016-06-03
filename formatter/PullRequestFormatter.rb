require_relative '../dto/PullRequest'
require_relative '../dto/User'

class PullRequestFormatter
  
  def initialize
  end
  
  def format(body)
    pullRequestList = []
    body.each  do |pullRequest|
      pullRequestToInsert = PullRequest.new
      creator = User.new
      reviewer = User.new
      creator.name = pullRequest['user']['login'];
      unless pullRequest['assignee'].nil?
        reviewer.name = pullRequest['assignee']['login']
      end
      pullRequestToInsert.creator = creator
      pullRequestToInsert.reviewer = reviewer
      pullRequestToInsert.url = pullRequest['html_url']
      pullRequestToInsert.openTimestamp = pullRequest['created_at']
      pullRequestToInsert.updatedTimestamp = pullRequest['updated_at']
      pullRequestToInsert.repository = pullRequest['head']['repo']['name']
      pullRequestToInsert.issueNumber = pullRequest['number']
      pullRequestList << pullRequestToInsert
    end
    return pullRequestList
  end 
end
