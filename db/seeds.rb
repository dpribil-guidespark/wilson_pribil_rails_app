# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

people = [{first_name: "Bob", last_name: "Benedict"}, 
          {first_name: "Emmanuel", last_name: "Pastor"}, 
          {first_name: "Edwin", last_name: "Montano"}, 
          {first_name: "Deepa", last_name: "Ramachandran"}, 
          {first_name: "Chris", last_name: "Sun"}, 
          {first_name: "Javier", last_name: "Lopez"}, 
          {first_name: "Andre", last_name: "Choi"},
          {first_name: "David", last_name: "Wilson"},
          {first_name: "David", last_name: "Pribil"},
          {first_name: "Sen", last_name: "Zhang"},
          {first_name: "Richard", last_name: "Chen"}
         ]

people.each do |u|
  User.create(u)
end

challenges = [{question: "42", answer: "The meaning of Life, the Universe, and Everything", hint: "Douglas Adams", user_id: 1},
              {question: "3.14", answer: "Pi", hint: "Tasty", user_id: 2},
              {question: "1.618", answer: "Golden Ratio", hint: "Da Vinci", user_id: 2},
              {question: "1,2,3,4,5", answer: "Counting", user_id: 1},
              {question: "02210", answer: "Zip code of Boston Office", hint: "East Coast", user_id: 1}
             ]

challenges.each do |c|
  Challenge.create(c)
end

c1 = Challenge.first
c1[:created_at] = c1[:created_at] - 21.days
c1[:updated_at] = c1[:updated_at] - 21.days
c1.save

c2 = Challenge.first.next
c2[:created_at] = c2[:created_at] - 15.days
c2[:updated_at] = c2[:updated_at] - 15.days
c2.save

c3 = Challenge.first.next.next
c3[:created_at] = c3[:created_at] - 11.days
c3[:updated_at] = c3[:updated_at] - 11.days
c3.save

c4 = Challenge.first.next.next.next
c4[:created_at] = c4[:created_at] - 6.days
c4[:updated_at] = c4[:updated_at] - 6.days
c4.save


guesses_1 = [{answer: "Meaning of life", user_id: 2, status: 1},
             {answer: "6 x 7", user_id: 3, status: 0},
             {answer: "Hitchiker's Guide", user_id: 4, status: 1},
             {answer: "Number of bugs in this app", user_id: 8, status: 0},
             {answer: "Meaning of Life", user_id: 9, status: 1}
            ]

guesses_1.each do |g|
  g[:challenge_id] = 1
  g[:department] = 5
  Guess.create(g)
end

guesses_2 = [{answer: "Pi", user_id: 1, status: 1},
             {answer: "Pi", user_id: 3, status: 1},
             {answer: "Pi", user_id: 5, status: 1},
             {answer: "Don't know", user_id: 8, status: 0},
             {answer: "Pi", user_id: 11, status: 1}
            ]

guesses_2.each do |g|
  g[:challenge_id] = 2
  g[:department] = 3
  Guess.create(g)
end

guesses_3 = [{answer: "Golden Ratio", user_id: 1, status: 1},
             {answer: "Length of Mona Lisa's Nose", user_id: 10, status: 0}
            ]

guesses_3.each do |g|
  g[:challenge_id] = 3
  g[:department] = 6
  Guess.create(g)
end


guesses_5 = [{answer: "Boston Office Address", user_id: 6, status: 0},
             {answer: "Sq ft in Boston Office", user_id: 4, status: 0},
             {answer: "Zip code of Boston Office", user_id: 2, status: 0}
            ]

guesses_5.each do |g|
  g[:challenge_id] = 5
  g[:department] = 2
  Guess.create(g)
end



Req.create({title: "Production Specialist", department: 2, manager: "Dharam Rai", description: "You love video. Short, long, narrative, corporate, educational – you name it, you’re interested in making it. Motion graphics? Bring it. Script customization? Yes please. GuideSpark’s rapidly growing Content Team is looking for a Content Production Specialist who can hit the ground running in this entry level position. You have experience with digital content and excellent written communications skills. Let’s not forget your stellar attention to detail. Errors? Typos? Not on your watch. This could be the right opportunity for you to join one of the most promising companies in America (as named by Forbes). You know how to effectively manage your time and crank up the output when you need to. You like the idea of learning new content development skills in writing and design, not to mention project management, and you’re excited to hone the ones you already have."})


