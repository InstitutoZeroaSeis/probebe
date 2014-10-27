class CreateMotherProfiles < ActiveRecord::Migration
  def change
    create_table :mother_profiles do |t|
      t.boolean :is_mother, null: false
      t.boolean :is_pregnant, null: false
      t.references :profile, index: true

      t.timestamps
    end
  end
end
