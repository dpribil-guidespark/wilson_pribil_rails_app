require 'spec_helper'

describe Challenge do

  before { @challenge = Challenge.new(question: "3.142", hint: "Tasty", answer: "Approximation to Pi", user_id: 1) }

  subject { @challenge }

  it { should respond_to(:question) }
  it { should respond_to(:hint) }
  it { should respond_to(:answer) }

  describe "when saving should fill in fields" do
    before { @challenge.save }
    it { should be_valid }
  end

  describe "when question is not present" do
    before { @challenge.question = " " }
    it { should_not be_valid }
  end

  describe "when answer is not present" do
    before { @challenge.answer = " " }
    it { should_not be_valid }
  end

  describe "when hint is not present" do
    before { @challenge.hint = " " }
    it { should be_valid }
  end


  describe "when question+answer is a duplicate" do
    before do 
      challenge_with_same_question = @challenge.dup
      challenge_with_same_question.save
    end
    it { should_not be_valid}
  end

end