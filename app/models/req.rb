class Req < ActiveRecord::Base

  validates :title, presence: true
  validates :department, presence: true

  def self.get_department_name(id)
    DEPARTMENT_CONSTANTS.find {|dc| dc[:id] == id}[:name]
  end

  def previous
    Req.where('reqs.id < ?', self.id).last
  end

  def next
    Req.where('reqs.id > ?', self.id).first
  end  


end
