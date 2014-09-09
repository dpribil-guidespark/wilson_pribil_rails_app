class ChangeFieldTypesInUsers < ActiveRecord::Migration
  def change
    change_column :challenges, :question, :text
    change_column :challenges, :answer, :text
    change_column :challenges, :hint, :text
  end
end
