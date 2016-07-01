class PullRequest
  attr_accessor :repo_owner,
                :creator,
                :reviewer,
                :url,
                :repository,
                :issue_number,
                :open_timestamp,
                :updated_timestamp

  def initialize(**pr)
    @repo_owner = pr['repo_owner']
    @creator = pr['creator']
    @url = pr['url']
    @repository = pr['repository']
    @issue_number = pr['issue_number']
    @open_timestamp = pr['open_timestamp']
    @updated_timestamp = pr['updated_timestamp']
    @reviewer = pr['reviewer']
  end
end
