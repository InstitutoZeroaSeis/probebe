class CreateAvatars < ActiveRecord::Migration
  def change
    create_table :avatars do |t|
      t.attachment :photo
      t.references :personal_profile

      t.timestamps
    end
  end
end
