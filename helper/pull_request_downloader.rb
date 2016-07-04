require_relative '../wrapper/rest_wrapper'
require_relative '../formatter/pull_request_formatter'
require_relative '../formatter/user_formatter'

class PullRequestDownloader
  BASE_URL = 'https://api.github.com/'.freeze

  def initialize(pull_request_formatter, user_formatter, rest_wrapper)
    @pull_request_formatter = pull_request_formatter
    @user_formatter = user_formatter
    @rest_wrapper = rest_wrapper
  end

  def download(owner, repository)
    incomplete_pull_requests = download_pull_requests(owner, repository)
    update_pull_requests(incomplete_pull_requests, owner)
  end

  private def download_pull_requests(owner, repository)
    url = build_pull_url(owner, repository)
    response = @rest_wrapper.get(url)
    @pull_request_formatter.format(response.body)
  end

  private def build_pull_url(owner, repository)
    BASE_URL + "repos/#{owner}/'+#{repository}/pulls"
  end

  private def update_pull_requests(incomplete_pull_request, owner)
    users_info = {}
    pull_requests = []

    incomplete_pull_request.each do |pull_request|
      user = get_user_information(pull_request.creator.name, users_info)
      pull_request.creator.email = user.email

      user = get_user_information(pull_request.reviewer.name, users_info)
      pull_request.reviewer.email = user.email

      pull_request.repoOwner = owner

      pull_requests << pull_request
    end
  end

  private def get_user_information(user_name, users_info)
    unless users_info.include? user_name
      user = download_user_information(user_name)
      users_info[user.name] = user
    end

    users_info[user_name] unless users_info[user_name].nil?
  end

  private def download_user_information(user_name)
    url = build_user_url(user_name)
    response = @rest_wrapper.get(url)
    @user_formatter.format(response.body)
  end

  private def build_user_url(user)
    BASE_URL + "users/#{user}"
  end
end
