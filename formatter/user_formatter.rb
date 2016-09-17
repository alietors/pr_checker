require_relative '../dto/user'

class UserFormatter
  def format(user:)
    user_to_insert = User.new
    user_to_insert.name = user['login']
    user_to_insert.email = user['email']

    user_to_insert
  end
end
