require_relative '../service/github_repository'
require_relative '../service/pull_request_evaluator'
require_relative '../helper/pull_request_downloader'
require_relative '../notificator/comment_writer'
require_relative '../formatter/message_formatter'

class Container
  def initialize(config)
    @di_container = {}

    @di_container['message_formatter'] = MessageFormatter.new(url: config['IMAGE_URL'])
    @di_container['pull_request_formatter'] = PullRequestFormatter.new
    @di_container['user_formatter'] = UserFormatter.new
    @di_container['rest_wrapper'] = RestWrapper.new(token: config['OAUTH_TOKEN'])
    @di_container['pr_downloader'] = PullRequestDownloader.new(
      pull_request_formatter: @di_container['pull_request_formatter'],
      user_formatter: @di_container['user_formatter'],
      rest_wrapper: @di_container['rest_wrapper']
    )
    @di_container['github_repository'] = GithubRepository.new(
      pull_request_downloader: @di_container['pr_downloader']
    )
    @di_container['comment_writer'] = CommentWriter.new(
      rest_wrapper: @di_container['rest_wrapper']
    )
    @di_container['pull_request_evaluator'] = PullRequestEvaluator.new(
      message_writer: @di_container['comment_writer'],
      message_formatter: @di_container['message_formatter'],
      day_limit_number: config['DAY_LIMIT_NUMBER']
    )
  end

  def get(key)
    @di_container[key]
  end
end
