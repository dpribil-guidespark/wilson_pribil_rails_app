require 'spec_helper'

describe Req do

  before { @req = Req.new(title: "Pi?", department: 4, manager: "Bob Benedict", description: "Lorem Ipsum") }

  subject { @req }

  it { should respond_to(:title) }
  it { should respond_to(:department)}
  it { should respond_to(:manager)}
  it { should respond_to(:description)}
  it { should respond_to(:id)}

  it { should be_valid}

end