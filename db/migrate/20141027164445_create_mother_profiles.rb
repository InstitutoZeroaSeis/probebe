class CreateMotherProfiles < ActiveRecord::Migration
  def change
    create_table :mother_profiles do |t|
      t.boolean :is_mother, null: false, default: true
      t.boolean :is_pregnant, null: false, default: true
      t.references :profile, index: true

      t.timestamps
    end
  end
end
