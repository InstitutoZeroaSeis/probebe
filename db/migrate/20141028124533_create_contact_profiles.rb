class CreateContactProfiles < ActiveRecord::Migration
  def change
    create_table :contact_profiles do |t|
      
      t.references :profile, index: true
      t.string :state
      t.string :city
      t.string :street
      t.timestamps
    end
  end
end
