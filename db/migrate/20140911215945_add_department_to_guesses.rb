class AddDepartmentToGuesses < ActiveRecord::Migration
  def change
    add_column :guesses, :department, :integer, :in => (0..7).to_a
  end
end
