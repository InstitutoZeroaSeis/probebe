class AddFatherTextToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :father_text, :text
  end
end
