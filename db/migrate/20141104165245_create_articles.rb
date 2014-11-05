class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :type
      t.string :title
      t.text :text
      t.text :summary
      t.references :user
      t.references :category
      t.references :parent_article
      t.timestamps
    end
  end
end
