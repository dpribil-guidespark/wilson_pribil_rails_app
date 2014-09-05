class User < ActiveRecord::Base
  has_many :challenges
  has_many :guesses
end
