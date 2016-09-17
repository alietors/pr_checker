require 'minitest/autorun'
require 'minitest/mock'

require_relative '../../formatter/user_formatter'
require_relative '../../dto/user'

class UserFormatterTest < Minitest::Test
  def setup
  end

  def test_format_user
    @user_formatter = UserFormatter.new
    github_user = { 'email' => 'test@email.com', 'login' => 'myName' }

    user = @user_formatter.format(user: github_user)

    assert_equal(github_user['login'], user.name)
    assert_equal(github_user['email'], user.email)
  end
end
