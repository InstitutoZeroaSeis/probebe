class AddChangeOmniauthPasswordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :change_omniauth_password, :boolean
  end
end
