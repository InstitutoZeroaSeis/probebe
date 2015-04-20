class AddPhoneFieldsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :cell_phone, :string
    add_column :profiles, :home_phone, :string
    add_column :profiles, :business_phone, :string
  end
end
