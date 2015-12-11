class AddMessageDayToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :message_days, :text
  end
end
