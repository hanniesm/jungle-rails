class User < ActiveRecord::Base
  
  has_secure_password
  
  has_many :orders
  has_many :reviews
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password_confirmation, presence: true
  validates :password, length: { minimum: 5}

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.downcase)
    if user && user.authenticate(password) 
      user
    else
      false
    end
  end

end