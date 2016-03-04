class AddSearchColumnToSiteUser < ActiveRecord::Migration
  def change
    add_column :users, :search_column, :string
  end
end
