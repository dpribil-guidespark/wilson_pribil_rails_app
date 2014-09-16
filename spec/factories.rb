# require 'spec_helper'
require 'faker'

FactoryGirl.define do

  factory :user do |f|
    f.first_name { Faker::Name.first_name}
    f.last_name { Faker::Name.last_name}
  end

  # factory :user do 
  #   first_name "David"
  #   last_name "Wilson"
  # end  



# end

# FactoryGirl.define do

  factory :challenge do |f|
    f.sequence(:question) {|n| "Question-#{n}"}
    f.sequence(:hint)  {|n| "This is hint-#{n}!"}
    f.sequence(:answer) {|n| "Answer #{n}"}
    user_id 1
  end

# end

# FactoryGirl.define do
  factory :guess do
    end
end