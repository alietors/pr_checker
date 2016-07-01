class PullRequest
  attr_accessor :repo_owner,
                :creator,
                :reviewer,
                :url,
                :repository,
                :issue_number,
                :open_timestamp,
                :updated_timestamp

  def initialize(
    repo_owner = '',
    creator = nil,
    reviewer = nil,
    url = '',
    repository = '',
    issue_number = '',
    open_timestamp = '',
    updated_timestamp = ''
  )
    @repo_owner = repo_owner
    @creator = creator
    @url = url
    @repository = repository
    @issue_number = issue_number
    @open_timestamp = open_timestamp
    @updated_timestamp = updated_timestamp
    @reviewer = reviewer
  end
end
