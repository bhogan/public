class Referee < ActiveRecord::Base
  belongs_to :user
  has_many :contests
  has_many :matches, as: :manager

  validates_numericality_of :players_per_game, :greater_than => 0, :less_than => 10, :only_integer => true
  validates :rules_url, presence: true, format: /https?:\/\/[\S]+/
  validates :name, presence: true, uniqueness: true
  validates :file_location, presence: true
  
  
  def upload=(uploaded_file)
    if uploaded_file.nil? 
      #problem no file
    else
      time_no_spaces = Time.now.to_s.gsub(/ / , '_')
      file_location = Rails.root.join( 'code', 'referees', Rails.env, time_no_spaces).to_s
      IO::copy_stream(uploaded_file, file_location)
    end
    self.file_location = "the location we end up with"
  end
  
  def referee
    self
  end
 
  
  
end
