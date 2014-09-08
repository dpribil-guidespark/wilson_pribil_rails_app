require 'spec_helper'

describe Challenge do

  before { @challenge = Challenge.new(question: "3.142", hint: "Tasty", answer: "Approximation to Pi") }

  subject { @challenge }

  it { should respond_to(:question) }
  it { should respond_to(:hint) }
  it { should respond_to(:answer) }



end