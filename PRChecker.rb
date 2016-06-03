require_relative 'GithubRepository'
require_relative 'notificator/EmailSender'
require_relative 'notificator/CommentWritter'
require_relative 'formatter/MessageFormatter'
require 'yaml'

config = YAML.load_file('config/config.yml')

puts config.inspect

messageFormatter = MessageFormatter.new
pullRequestFormatter = PullRequestFormatter.new
userFormatter = UserFormatter.new
restWrapper = RestWrapper.new(config['OAUTH_TOKEN'])
PRDownloader = PullRequestDownloader.new(pullRequestFormatter, userFormatter, restWrapper)
repo = GithubRepository.new(PRDownloader)
commentWritter = CommentWritter.new(messageFormatter, restWrapper)

repo.setOwner(config['REPO_OWNER'])
repo.setRepository(config['REPO_NAME'])
pullRequests = repo.downloadPullRequests

commentWritter.sendMessage(pullRequests)

