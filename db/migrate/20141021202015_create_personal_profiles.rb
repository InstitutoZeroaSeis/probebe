class CreatePersonalProfiles < ActiveRecord::Migration
  def change
    create_table :personal_profiles do |t|
      t.string :first_name
      t.string :last_name
      t.integer :gender
      t.date :birth_date
      t.string :avatar
      t.references :profile, index: true

      t.timestamps
    end
  end
end
