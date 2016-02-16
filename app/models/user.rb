require 'bcrypt'
class User < ActiveRecord::Base
  attr_accessor :password

  validates :password, presence: :true, confirmation: :true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :email, presence: :true

  before_save :encrypt_password

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  private

    def encrypt_password
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
end
