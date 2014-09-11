class Guess < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :user
  validates :challenge_id, presence: true
  validates :user_id, presence: true
  validates :answer, presence: true
  validates :department, presence: true

  def self.get_department_name(id)
    DEPARTMENT_CONSTANTS.find {|dc| dc[:id] == id}[:name]
  end

end
