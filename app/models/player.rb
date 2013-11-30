class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :contest
  has_many :player_matches
  has_many :matches, through: :player_matches
  validates_presence_of :user_id, :contest_id
  validates :name, presence: true, uniqueness: {scope: :contest}
  validates :description, presence: true 
  validates :file_location, presence: true
end
