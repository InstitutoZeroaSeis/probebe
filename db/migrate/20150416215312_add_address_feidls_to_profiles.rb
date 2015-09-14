class AddAddressFeidlsToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :address_complement, :string
    add_column :profiles, :postal_code, :string
  end
end
