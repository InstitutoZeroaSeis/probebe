class CreateArticleReferences < ActiveRecord::Migration
  def change
    create_table :article_references do |t|
      t.string :source
      t.references :article
      t.timestamps
    end
  end
end
