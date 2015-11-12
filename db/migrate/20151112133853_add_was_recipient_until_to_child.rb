class AddWasRecipientUntilToChild < ActiveRecord::Migration
  def change
    add_column :children, :was_recipient_until, :datetime
  end
end
