class PullRequestEvaluator
  def initialize(message_writer, message_formatter, day_limit_number)
    @message_formatter = message_formatter
    @day_limit_number = day_limit_number
    @message_writer = message_writer
  end

  def evaluate_pull_requests(pull_requests)
    pull_requests.each do |pull_request|
      if require_message?(pull_request)
        message = format_message(pull_request)
        @message_writer.send(message, pull_request)
      end
    end
  end

  private def require_message?(pull_request)
    old_pull_request?(pull_request) && assignee?(pull_request)
  end

  private def old_pull_request?(pull_request)
    red_line_time = DateTime.now - @day_limit_number
    pr_updated = DateTime.rfc3339(pull_request.updated_timestamp)
    (red_line_time <=> pr_updated) == 1
  end

  private def assignee?(pull_request)
    !pull_request.reviewer.name.empty?
  end

  private def format_message(pull_request)
    @message_formatter.format_message(pull_request)
  end
end
