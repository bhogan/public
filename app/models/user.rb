class User < ActiveRecord::Base
  has_secure_password
  
  validates :username, presence: true, length: {maximum: 25}, uniqueness: true
  validates :email, presence: true, format: /\A[^\s]+@([a-z0-9]+\.)+\w+\z/i

  #comment
  
end
