class Contest < ActiveRecord::Base
  belongs_to :user
  belongs_to :referee
  has_many :matches, as: :manager
  has_many :players
  validates_presence_of :user, :referee
end