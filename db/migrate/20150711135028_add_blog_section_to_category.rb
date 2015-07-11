class AddBlogSectionToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :blog_section, :boolean, default: false
  end
end
