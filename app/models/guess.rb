class Guess < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :user
  validates :challenge_id, presence: true
  validates :user_id, presence: true
  validates :answer, presence: true

  before_save do
    #find challenge_id
    current_time = self.created_at
    last_challenge = Challenge.where(created_at: current_time-(7.day)..current_time)
    self.challenge_id = last_challenge[:id]

    #find user_id


  end

end
