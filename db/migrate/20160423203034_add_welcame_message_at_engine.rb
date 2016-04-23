class AddWelcameMessageAtEngine < ActiveRecord::Migration
  def change
    add_column :engines, :welcame_message, :text
  end
end
