require_relative '../service/GithubRepository'
require_relative '../helper/PullRequestDownloader'
require_relative '../notificator/CommentWritter'
require_relative '../formatter/MessageFormatter'

class Container
  def initialize(config)
    @diContainer = Hash.new
    
    @diContainer['message_formatter'] = MessageFormatter.new(config['IMAGE_URL'])
    @diContainer['pull_request_formatter'] = PullRequestFormatter.new
    @diContainer['user_formatter'] = UserFormatter.new
    @diContainer['rest_wrapper'] = RestWrapper.new(config['OAUTH_TOKEN'])
    @diContainer['pr_downloader'] = PullRequestDownloader.new(@diContainer['pull_request_formatter'], @diContainer['user_formatter'], @diContainer['rest_wrapper'])
    @diContainer['github_repository'] = GithubRepository.new(@diContainer['pr_downloader'])
    @diContainer['comment_writter'] = CommentWritter.new(@diContainer['message_formatter'], @diContainer['rest_wrapper'], config['DAY_LIMIT_NUMBER'])
  end
  
  def get(key)
    return @diContainer[key]
  end
end