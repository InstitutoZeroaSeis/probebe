class AddMaxRecipientChildrenToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :max_recipient_children, :integer
  end
end
