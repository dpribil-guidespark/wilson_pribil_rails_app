require 'spec_helper'

describe User do

  before { @user = User.new(first_name: "David", last_name: "Wilson") }

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }

  it { should be_valid }

  describe "when first name is not present" do
    before { @user.first_name = " " }
    it { should_not be_valid }
  end

  describe "when last name is not present" do
    before { @user.last_name = " " }
    it { should_not be_valid }
  end

  describe "when user is a duplicate" do
    before do
      user_with_same_name = @user.dup
      user_with_same_name.save
      # user_with_same_name.first_name = @user.first_name.upcase
      # user_with_same_name.last_name = @user.last_name.upcase
    end
    it { should_not be_valid}
  end
end