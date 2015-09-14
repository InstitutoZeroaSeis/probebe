class ChangeArticlePublishedDefaultValueToTrue < ActiveRecord::Migration
  def up
    change_column :articles, :publishable, :boolean, default: true
  end

  def down
    change_column :articles, :publishable, :boolean, default: false
  end
end
