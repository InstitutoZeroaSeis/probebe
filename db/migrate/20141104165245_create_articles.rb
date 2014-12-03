class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :type
      t.string :title
      t.text :text
      t.text :summary
      t.text :box
      t.integer :gender, default: 2
      t.integer :category_id
      t.boolean :teenage_pregnancy
      t.integer :baby_target_type
      t.integer :minimum_valid_week
      t.integer :maximum_valid_week
      t.integer :journalistic_articles_count, default: 0, null: false
      t.references :user
      t.references :category
      t.references :parent_article
      t.references :original_author
      t.timestamps
    end
  end
end
