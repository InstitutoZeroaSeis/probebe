class UpdateSearchColumnToUser < ActiveRecord::Migration
  def change
    User.all.each do |user|
      unless user.search_column.present?
        user.update_columns(search_column: "#{user.email} #{user.profile.name} #{user.profile.cell_phone}")
      end
    end
  end
end
