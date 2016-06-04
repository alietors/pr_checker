require_relative '../dto/User'

class UserFormatter
  
  def format(user)
    userToInsert = User.new
    userToInsert.name = user['login']
    userToInsert.email = user['email']

    return userToInsert
  end 
end