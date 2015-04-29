class RemovePhoneFieldsFromProfile < ActiveRecord::Migration
  def change
    remove_column :profiles, :home_phone, :string
    remove_column :profiles, :business_phone, :string
  end
end
