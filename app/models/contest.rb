class Contest < ActiveRecord::Base
  belongs_to :user
  belongs_to :referee
  has_many :matches, as: :manager
  has_many :players
  
  validates_presence_of :user, :referee  
  
  validates :name, length: { minimum: 2 }, uniqueness: true  
  validates :contest_type, presence: true
  validates :start, presence: true
  validates :deadline, presence: true
  validates :description, presence: true 

  validates_datetime :deadline, :on_or_after => lambda { Time.now.change(:usec =>0) }
  validates_datetime :start, :on_or_after => lambda { :deadline }
end