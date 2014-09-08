require 'spec_helper'

describe Guess do

  before { @guess = Guess.new(answer: "Pi?") }

  subject { @guess }

  it { should respond_to(:answer) }

  describe "when saving should fill in fields" do
    before { @guess.save }
    it { should respond_to(:challenge_id)}
    it { should respond_to(:user_id)}
    it { should be_valid }
  end

  describe "when first created status should be 0" do
    it { should respond_to(:status)}
    its(:status) { should eq STATUS_WRONG}
  end

end