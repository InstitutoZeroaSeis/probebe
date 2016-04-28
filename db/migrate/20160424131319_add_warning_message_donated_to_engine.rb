class AddWarningMessageDonatedToEngine < ActiveRecord::Migration
  def change
    add_column :engines, :warning_message_donated, :text
  end
end
