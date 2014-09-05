class AddChallengeIdToGuess < ActiveRecord::Migration
  def change
    add_column :guesses, :challenge_id, :integer
  end
end
