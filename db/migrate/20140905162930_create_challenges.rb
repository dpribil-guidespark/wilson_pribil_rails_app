class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :question
      t.string :hint
      t.string :answer

      t.timestamps
    end
  end
end
