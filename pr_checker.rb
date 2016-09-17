require 'yaml'
require_relative 'di/container'

config = YAML.load_file('config/config.yml')

container = Container.new(config)

repo = container.get('github_repository')
repo.owner = config['REPO_OWNER']
repo.repository = config['REPO_NAME']

pr_evaluator = container.get('pull_request_evaluator')

pull_requests = repo.download_pull_requests
pr_evaluator.evaluate_pull_requests(pull_requests: pull_requests)
