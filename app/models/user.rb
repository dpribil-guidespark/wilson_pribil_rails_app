class User < ActiveRecord::Base
  has_many :challenges
  has_many :guesses
  validates :first_name, presence: true
  validates :last_name, presence: true
end
