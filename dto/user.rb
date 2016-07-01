class User
  attr_accessor :name, :email

  def initialize(**user)
    @name = user['name']
    @email = user['email']
  end
end
