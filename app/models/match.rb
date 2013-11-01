class Match < ActiveRecord::Base
  belongs_to :manager, polymorphic: true
  has_many :player_matches
  has_many :players, through: :player_matches
  validates_presence_of :manager
end
