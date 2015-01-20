class RemoveHomePhoneNumberFromProfile < ActiveRecord::Migration
  def change
    remove_column :profiles, :home_phone_number, :string
  end
end
