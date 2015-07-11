class AddBlogCategory < ActiveRecord::Migration
  def up
    parent_blog = Category.create name: 'Blog',
                                  show_in_home: false,
                                  blog_section: true
    blog = Category.create name: 'Blog',
                           show_in_home: false,
                           blog_section: true,
                           parent_category: parent_blog
  end

  def down
  end
end
