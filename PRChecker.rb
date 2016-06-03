require 'yaml'
require_relative 'di/Container'

config = YAML.load_file('config/config.yml')

container = Container.new(config)

repo = container.get('repo')
repo.setOwner(config['REPO_OWNER'])
repo.setRepository(config['REPO_NAME'])
 
commentWritter = container.get('commentWritter')

pullRequests = repo.downloadPullRequests
commentWritter.sendMessage(pullRequests)

  