class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.string :name
      t.integer :gender
      t.datetime :birth_date
      t.boolean :born
      t.date :pregnancy_start_date
      t.references :mother_profile

      t.timestamps
    end
  end
end
