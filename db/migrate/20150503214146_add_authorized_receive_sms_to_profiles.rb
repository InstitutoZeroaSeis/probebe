class AddAuthorizedReceiveSmsToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :authorized_receive_sms, :boolean, default: false
  end
end
