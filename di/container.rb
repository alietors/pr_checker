require_relative '../service/github_repository'
require_relative '../service/pull_request_evaluator'
require_relative '../helper/pull_request_downloader'
require_relative '../notificator/comment_writter'
require_relative '../formatter/message_formatter'

class Container
  def initialize(config)
    @di_container = {}

    @di_container['message_formatter'] = MessageFormatter.new(
      config['IMAGE_URL']
    )
    @di_container['pull_request_formatter'] = PullRequestFormatter.new
    @di_container['user_formatter'] = UserFormatter.new
    @di_container['rest_wrapper'] = RestWrapper.new(config['OAUTH_TOKEN'])
    @di_container['pr_downloader'] = PullRequestDownloader.new(
      @di_container['pull_request_formatter'],
      @di_container['user_formatter'],
      @di_container['rest_wrapper']
    )
    @di_container['github_repository'] = GithubRepository.new(
      @di_container['pr_downloader']
    )
    @di_container['comment_writter'] = CommentWritter.new(
      @di_container['rest_wrapper']
    )
    @di_container['pull_request_evaluator'] = PullRequestEvaluator.new(
      @di_container['comment_writter'],
      @di_container['message_formatter'],
      config['DAY_LIMIT_NUMBER']
    )
  end

  def get(key)
    @di_container[key]
  end
end
