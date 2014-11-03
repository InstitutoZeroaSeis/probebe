class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.string :name
      t.integer :gender
      t.date :birth_date
      t.boolean :born
      t.date :pregnancy_start_date
      t.references :profile

      t.timestamps
    end
  end
end
