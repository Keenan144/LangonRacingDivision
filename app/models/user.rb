require 'bcrypt'

class User < ActiveRecord::Base

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :email, presence: true
  validates :email, uniqueness: true
  # validates :username, format: { with: /\A[a-z0-9_-]{3,20}\z/}
  validates :name, presence: true

  include BCrypt
  
  def password
    @password || Password.new(password_hash)
  end

  def password=( new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate(password)
    self.password == password
  end

end