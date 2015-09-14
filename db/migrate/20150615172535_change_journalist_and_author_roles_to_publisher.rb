class ChangeJournalistAndAuthorRolesToPublisher < ActiveRecord::Migration
  def up
    User.where(role: 2).update_all(role: 1)
    User.where(role: 3).update_all(role: 2)
  end

  def down

  end
end
