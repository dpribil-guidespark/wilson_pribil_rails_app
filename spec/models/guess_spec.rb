require 'spec_helper'

describe Guess do

  before { @guess = Guess.new(answer: "Pi?") }

  subject { @guess }

  it { should respond_to(:answer) }

  it { should be_valid }


end