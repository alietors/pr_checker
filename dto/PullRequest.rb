class PullRequest
    attr_accessor :repoOwner, :creator, :reviewer, :url, :repository, :issueNumber, :openTimestamp, :updatedTimestamp
    
    def initialize (repoOwner = '',
                    creator = nil,
                    reviewer = nil,
                    url = '',
                    repository = '',
                    issueNumber = '',
                    openTimestamp = '',
                    updatedTimestamp = '')
        @repoOwner = repoOwner
        @creator = creator
        @url = url
        @repository = repository
        @issueNumber = issueNumber
        @openTimestamp = openTimestamp
        @updatedTimestamp = updatedTimestamp
        @reviewer = reviewer
    end
end