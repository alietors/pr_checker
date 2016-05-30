require_relative 'GithubRepository'

repo = GithubRepository.new
repo.setOwner('alietors')
repo.setRepository('pr_checker')
pullRequestList = repo.downloadPullRequests
print pullRequestList