require 'spec_helper'

describe User do

  before { @user = User.new(first_name: "David", last_name: "Wilson") }

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }


end