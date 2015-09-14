class AddIntroTextToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :intro_text, :string
  end
end
