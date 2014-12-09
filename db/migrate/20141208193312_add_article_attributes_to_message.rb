class AddArticleAttributesToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :gender, :integer, default: 2
    add_column :messages, :teenage_pregnancy, :integer
    add_column :messages, :baby_target_type, :integer
    add_column :messages, :minimum_valid_week, :integer
    add_column :messages, :maximum_valid_week, :integer
    add_reference :messages, :category
  end
end
