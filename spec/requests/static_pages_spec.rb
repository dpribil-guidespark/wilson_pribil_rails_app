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

  describe "Home page" do

    describe "without a database should ask to create a new challenge" do
      before { visit home_path }
      it { should have_content('Create a New Challenge')}
      it { should have_content('Create Challenge')}

      it { should_not have_content('Challenge of the Week') }
    end
  end

  describe "Home page" do

    describe "with a database should show the latest challenge" do
      before {@userA = User.create(first_name: "David", last_name: "Wilson")}
      before {@challengeA = Challenge.create(question: "42", answer: "The Answer", user_id: @userA[:id])}
      before {@challengeB = Challenge.create(question: "12345", answer: "sequence", user_id: @userA[:id])}
      before { visit home_path }

      it { should_not have_content('Create a New Challenge')}
      it { should_not have_content('Create Challenge')}

      it { should have_content('Challenge of the Week') }
      it { should have_content(@challengeB.question) }
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

  describe "Interactive Leaderboard" do

    describe "should contain the previous challenges question, answer and setter" do
      let (:user) { FactoryGirl.create(:user) }
      let (:challengeA) { FactoryGirl.create(:challenge) }
      let (:challengeB) { FactoryGirl.create(:challenge) }
      before { visit leaderboard_path }

      it { should have_content(challengeA.question) }
      it { should have_content(challengeA.answer) }

      it { should_not have_content(challengeB.question) }
      it { should_not have_content(challengeB.answer) }
    end

    describe "should contain the previous challenge hint if present" do
      let (:user) { FactoryGirl.create(:user) }      
      let (:challengeA) { FactoryGirl.create(:challenge) }
      let (:challengeB) { FactoryGirl.create(:challenge) }
      before { visit leaderboard_path }

      it { should have_content(challengeA.hint) }
      it { should_not have_content(challengeB.hint) }
    end

    describe "should contain the previous challenge winners, if any" do

    end

  end

end