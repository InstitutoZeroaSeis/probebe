class Admin::PostsController < Admin::ArticlesController
  def table_items
    Articles::ArticleWithImageCover.
      joins(:category).
      where('categories.blog_section = ?', true)
  end

  def create
    @model = Articles::Article.new(create_parameters)
    if @model.save
      flash[:notice] = I18n.t('messages.created')
      redirect_to action: :edit, id: @model.id
    else
      render action: 'new'
    end
  end

  protected

  def create_parameters
    category = Category.find_by_blog_section(true).categories.first
    parameters = build_resource_params.first
    parameters[:category_id] = category.id
    parameters
  end

end
