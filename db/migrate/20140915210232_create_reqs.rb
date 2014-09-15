class CreateReqs < ActiveRecord::Migration
  def change
    create_table :reqs do |t|
      t.string :title
      t.integer :department
      t.string :manager
      t.text :description

      t.timestamps
    end
  end
end
