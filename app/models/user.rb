class User < ActiveRecord::Base
has_secure_password

has_many :reviews
validates :email, uniqueness: {case_sensitive: false}
validates_presence_of :password_digest
validates_presence_of :email
validates_presence_of :last_name
validates_presence_of :first_name
validates :password, length: {minimum: 6}

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email)
    if !user
      return nil
    else
      user.authenticate(password)
    end
  end


end
