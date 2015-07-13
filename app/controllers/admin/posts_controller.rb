class Admin::PostsController < Admin::ArticlesController
  def table_items
    Articles::ArticleWithImageCover.
      joins(:category).
      where('categories.blog_section = ?', true)
  end

  def create
    category = Category.find_by_blog_section(true).categories.first
    parametes = build_resource_params.first
    parametes[:category_id] = category.id
    @article = Articles::Article.new parametes
    if @article.save
      flash[:notice] = I18n.t('messages.created')
      redirect_to action: :edit, id: @article.id
    else
      redirect_to action: :new
    end
  end

end
