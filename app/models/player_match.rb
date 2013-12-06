class PlayerMatch < ActiveRecord::Base
  belongs_to :player
  belongs_to :match
  validates_presence_of :player, :match
  

end
