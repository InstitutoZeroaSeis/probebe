class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.date :birth_date
      t.integer :gender, default: 2
      t.references :user, index: true
      t.string :city
      t.string :first_name
      t.string :last_name
      t.string :state
      t.string :street
      t.string :home_phone_number

      t.timestamps
    end
  end
end
