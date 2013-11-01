class User < ActiveRecord::Base
  has_secure_password
  
  has_many :contests
  has_many :referees
  
  validates :username, presence: true, length: {maximum: 25}, uniqueness: true
  validates :email, presence: true, format: /\A[^\s]+@([a-z0-9]+\.)+\w+\z/i


  
end
