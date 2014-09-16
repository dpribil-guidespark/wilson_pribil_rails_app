require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Global About page" do
    before { visit about_path }

    describe "include basic information" do
      it { should have_content('Wins of the Week') }
      it { should have_content('GuideSpark')}
    end 

    describe "include reporting problems information" do
      it { should have_content('Any Problems?')}
      it { should have_content('David Pribil')}
      it { should have_content('David Wilson')}
      it { should have_content('dpribil')}
      it { should have_content('dwilson')}
    end

    describe "should have correct title" do
     it { should have_title("| About")}
     it { should have_title("Wins of the Week")}
   end
  end

  describe "GOTW About page" do
    before { visit geek_of_the_week_about_path }

    describe "include basic information" do
      it { should have_content('Geek of the Week') }
      it { should have_content('GuideSpark')}
    end

    describe "include reporting problems information" do
      it { should have_content('Any Problems?')}
      it { should have_content('David Pribil')}
      it { should have_content('David Wilson')}
      it { should have_content('dpribil')}
      it { should have_content('dwilson')}
    end

    describe "should have correct title" do
     it { should have_title("| About")}
     it { should have_title("Geek of the Week")}
   end
  end

  describe "ROTW About page" do
    before { visit req_of_the_week_about_path }

    describe "include basic information" do
      it { should have_content('Req of the Week') }
      it { should have_content('GuideSpark')}
    end

    describe "include reporting problems information" do
      it { should have_content('Any Problems?')}
      it { should have_content('David Pribil')}
      it { should have_content('David Wilson')}
      it { should have_content('dpribil')}
      it { should have_content('dwilson')}
    end

    describe "should have correct title" do
     it { should have_title("| About")}
     it { should have_title("Req of the Week")}
   end
  end    

  describe "Global Home page" do
    before {visit root_path}

    describe "should link to sub-sites" do
      it { should have_link('Geek of the Week', href: geek_of_the_week_home_path)}
      it { should have_link('Req of the Week',  href: req_of_the_week_home_path)}
      it { should have_link("GuideSpark Internal Site", href: "http://intranet.guidespark.net/")}
    end

    describe "should have correct title" do
      it { should have_title("Wins of the Week")}
    end
  end


  describe "GOTW Home page" do

    describe "without a database should ask to create a new challenge" do
      before { visit geek_of_the_week_home_path }
      it { should have_content('Create a New Challenge')}
      it { should have_content('Create Challenge')}

      it { should_not have_content('Challenge of the Week') }
    end
  end

  describe "GOTW Home page" do

    # describe "with a database should show the latest challenge" do
    #   before {@userA = User.create(first_name: "David", last_name: "Wilson")}
    #   before {@challengeA = Challenge.create(question: "42", answer: "The Answer", user_id: @userA[:id])}
    #   before {@challengeB = Challenge.create(question: "12345", answer: "sequence", user_id: @userA[:id])}
    #   before { visit geek_of_the_week_home_path }

    #   it { should_not have_content('Create a New Challenge')}
    #   it { should_not have_content('Create Challenge')}

    #   it { should have_content('Challenge of the Week') }
    #   it { should have_content(@challengeB.question) }
    # end

  end


  describe "GOTW Leaderboard page" do
    before { visit geek_of_the_week_leaderboard_path }

    describe "should have correct title" do
      it { should have_title("Geek of the Week") }
      it { should have_title("| Leaderboard")}
    end

    describe "should have panel headings" do
      it { should have_content('Previous Challenge')}
      it { should have_content('Leaderboard:')}
    end

    describe "empty databases should provide replacement text" do
      # When all databases uninitialized
      it { should have_content('No completed challenges!')}
      it { should have_content('There are currently no geeks!')}
    end
  end

  describe "GOTW Interactive Leaderboard" do

    describe "should contain the previous challenges question, answer and setter" do
      before {@userA = User.create(first_name: "David", last_name: "Wilson")}
      before {@challengeA = Challenge.create(question: "42", answer: "The Answer", hint: "This is a hint", user_id: @userA[:id])}
      before {@challengeB = Challenge.create(question: "12345", answer: "sequence", user_id: @userA[:id])}
      before { visit geek_of_the_week_leaderboard_path }

      describe "should have previous challenge details" do 
        it { should have_content(@challengeA.question) }
        it { should have_content(@challengeA.answer) }
      end

      describe "should not have current challenge details" do
        it { should_not have_content(@challengeB.question) }
        it { should_not have_content(@challengeB.answer) }
      end

      describe "should contain the previous challenge hint if present" do
        it { should have_content(@challengeA.hint) }
        
        describe "but not if no hint" do
          before {@challengeC = Challenge.create(question: "abc", answer: "letters", user_id: @userA[:id])}
          before { visit geek_of_the_week_leaderboard_path }
          it { should_not have_content("Hint")}
        end
      end

      describe "no winners" do
        it {should have_content("No winners for this challenge!")}
      end

      describe "one winner" do
        before {@userB = User.create(first_name: "Bob", last_name: "Benedict")}
        before {@guessA = Guess.create(answer:"A guess", challenge_id: @challengeA[:id], user_id: @userB[:id], status: 1, department: 1)}
        before {visit geek_of_the_week_leaderboard_path}
        it {should have_content("This Challenge's Geek:")}
      end

      describe "multiple winner" do
        before {@userB = User.create(first_name: "Bob", last_name: "Benedict")}
        before {@userC = User.create(first_name: "Emmanuel", last_name: "Pastor")}
        before {@guessA = Guess.create(answer:"A guess", challenge_id: @challengeA[:id], user_id: @userB[:id], status: 1, department: 1)}
        before {@guessA = Guess.create(answer:"A guess", challenge_id: @challengeA[:id], user_id: @userC[:id], status: 1, department: 1)}
        before {visit geek_of_the_week_leaderboard_path}
        it {should have_content("This Challenge's Geeks:")}
      end
    end

  end

end