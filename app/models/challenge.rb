class Challenge < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  has_many :guesses
  validates :question, presence: true, :uniqueness => {:scope => :answer}
  validates :answer,   presence: true

  def previous
    Challenge.where('challenges.id < ?', self.id).last
  end

  def next
    Challenge.where('challenges.id > ?', self.id).first
  end  


end
