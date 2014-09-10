require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "About page" do
    before { visit about_path }

    it { should have_content('Geek of the Week') }
    it { should have_content('GuideSpark')}
    it { should have_content('Wins Meeting')}

    describe "include reporting problems information" do
      it { should have_content('Any Problems?')}
      it { should have_content('David Pribil')}
      it { should have_content('David Wilson')}
      it { should have_content('dpribil')}
      it { should have_content('dwilson')}
    end

    describe "should have correct title" do
     it { should have_title('Geek of the Week | About')}
   end
  end

  describe "Leaderboard page" do
    before { visit leaderboard_path }

    describe "should have correct title" do
      it { should have_title('Geek of the Week | Leaderboard')}
    end

    describe "should have panel headings" do
      it { should have_content('Last Challenge:')}
      it { should have_content('Leaderboard:')}
    end

    describe "empty databases should provide replacement text" do
      # When all databases uninitialized
      it { should have_content('No completed challenges!')}
      it { should have_content('There are currently no geeks!')}
    end
  end

end