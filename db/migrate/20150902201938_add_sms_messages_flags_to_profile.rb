class AddSmsMessagesFlagsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :profile_completed_message_sent, :boolean, default: false
    add_column :profiles, :allow_sms_message_sent, :boolean, default: false
  end
end
