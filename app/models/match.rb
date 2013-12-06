class Match < ActiveRecord::Base
  belongs_to :manager, polymorphic: true
  belongs_to :contest
  belongs_to :referee
  has_many :players, through: :player_matches
  has_many :player_matches
  validates_presence_of :manager
  validates_presence_of :status
  validates_datetime :earliest_start, :if => :check_start
  validates_date :completion, :on_or_before => lambda { Time.now.change(:usec =>0) }, :if => :check_completed

  
  def check_start
    if self.status == "Completed" || self.status == "Started"
      return false
    else
      return true
    end
  end
  
  def check_completed
    self.status == "Completed"
  end
  
  def check_num_of_players
    if self.players && self.manager
      if self.players.count != self.manager.referee.players_per_game
        errors.add(:manager, "Not correct number of players")
      end
    end
  end
  
  
  

end
