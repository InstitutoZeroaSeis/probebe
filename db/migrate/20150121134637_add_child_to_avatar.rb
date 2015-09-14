class AddChildToAvatar < ActiveRecord::Migration
  def change
    add_reference :avatars, :child
  end
end
