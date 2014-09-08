class Challenge < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  has_many :guesses
  validates :question, presence: true
  validates :answer,   presence: true


end
