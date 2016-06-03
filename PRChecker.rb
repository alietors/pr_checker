require_relative 'GithubRepository'
require_relative 'notificator/EmailSender'
require_relative 'notificator/CommentWritter'
require_relative 'formatter/MessageFormatter'

messageFormatter = MessageFormatter.new
pullRequestFormatter = PullRequestFormatter.new
userFormatter = UserFormatter.new
restWrapper = RestWrapper.new
PRDownloader = PullRequestDownloader.new(pullRequestFormatter, userFormatter, restWrapper)
repo = GithubRepository.new(PRDownloader)
commentWritter = CommentWritter.new(messageFormatter, restWrapper)

repo.setOwner('alietors')
repo.setRepository('pr_checker')
pullRequests = repo.downloadPullRequests

commentWritter.sendMessage(pullRequests)