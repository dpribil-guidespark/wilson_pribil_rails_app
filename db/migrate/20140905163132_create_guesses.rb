class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.string :answer
      t.integer :status

      t.timestamps
    end
  end
end
