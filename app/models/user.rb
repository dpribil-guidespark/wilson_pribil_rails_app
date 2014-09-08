class User < ActiveRecord::Base
  has_many :challenges
  has_many :guesses
  validates :first_name, presence: true, :uniqueness => {:scope => :last_name}
  validates :last_name, presence: true

  before_save {self.first_name = first_name.capitalize}
  before_save {self.last_name = last_name.capitalize}

end
