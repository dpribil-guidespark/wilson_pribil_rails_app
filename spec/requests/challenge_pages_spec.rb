require 'spec_helper'

describe "Challenge pages" do

  subject { page }

  describe "Home page" do
    before { visit user_challenge_path(id: 1, user_id: 1) }

    # it { should have_content('Guidespark') }
    # it { should have_content('Geek of the Week') }
  end

end