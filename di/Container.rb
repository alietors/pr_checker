require_relative '../service/GithubRepository'
require_relative '../helper/PullRequestDownloader'
require_relative '../notificator/CommentWritter'
require_relative '../formatter/MessageFormatter'

class Container
  def initialize(config)
    @diContainer = Hash.new
    
    @diContainer['messageFormatter'] = MessageFormatter.new
    @diContainer['pullRequestFormatter'] = PullRequestFormatter.new
    @diContainer['userFormatter'] = UserFormatter.new
    @diContainer['restWrapper'] = RestWrapper.new(config['OAUTH_TOKEN'])
    @diContainer['PRDownloader'] = PullRequestDownloader.new(@diContainer['pullRequestFormatter'], @diContainer['userFormatter'], @diContainer['restWrapper'])
    @diContainer['repo'] = GithubRepository.new(@diContainer['PRDownloader'])
    @diContainer['commentWritter'] = CommentWritter.new(@diContainer['messageFormatter'], @diContainer['restWrapper'], config['DAY_LIMIT_NUMBER'])
  end
  
  def get(key)
    return @diContainer[key]
  end
end