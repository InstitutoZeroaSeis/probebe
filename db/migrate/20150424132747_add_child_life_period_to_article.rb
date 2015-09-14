class AddChildLifePeriodToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :child_life_period, :integer
  end
end
