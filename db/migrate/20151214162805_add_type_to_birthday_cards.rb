class AddTypeToBirthdayCards < ActiveRecord::Migration
  def change
    add_column :birthday_cards, :type, :integer, default: 0
  end
end
