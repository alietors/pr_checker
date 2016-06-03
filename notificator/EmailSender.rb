require 'date'

class EmailSender
  
  def initialize(messageFormatter)
    @messageFormatter = messageFormatter
  end
  
  def sendMessage(pullRequests)
    pullRequests.each do | pullRequest |
      if(self.isPullRequestOld(pullRequest))
        message = self.formatMessage(pullRequest)
        self.send(message)
      end
    end
  end
  
  def isPullRequestOld(pullRequest)
    redLineTime = DateTime.now - 2
    prUpdated = DateTime.rfc3339(pullRequest.updatedTimestamp)
    return redLineTime <=> prUpdated   
  end
  
  def formatMessage(pullRequest)
    @messageFormatter.formatMessage(pullRequest);
  end
  
  def send(message)
    puts message
  end

end
