class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.string :name
      t.datetime :birth_date
      t.integer :gender
      t.references :mother_profile

      t.timestamps
    end
  end
end
