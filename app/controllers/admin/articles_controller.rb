class Admin::ArticlesController < Admin::AdminController
  defaults resource_class: Articles::ArticleWithImageCover
  load_and_authorize_resource(
    class: 'Articles::ArticleWithImageCover'
  )

  layout 'carnival/admin'

  def table_items
    Articles::Article.includes(:category, :user)
  end

  def show
    if current_user.site_user?
      redirect_to post_path(params[:id])
    else
      super
    end
  end

  def create
    create! do |success, failure|
      success.html do
        flash[:notice] = I18n.t('messages.created')
        redirect_to action: :edit, id: @article.id
      end
      failure.html { instantiate_model && render('new') }
    end
  end

  def update
    update! do |success, failure|
      success.html do
        flash[:notice] = I18n.t('messages.updated')
        redirect_to action: :edit
      end
      failure.html { instantiate_model && render('edit') }
    end
  end

  protected

  def create_resource(resource)
    @article = resource
    @article.save
  end

  def build_resource_params
    return if params[:articles_article].nil?
    [
      params.require(:articles_article).permit(
        :text, :title, :intro_text, :category_id, :user_id,
        :original_author_id, :gender, :teenage_pregnancy, :baby_target_type,
        :publishable, :cover_picture_id, :thumb_picture_id, :box, :minimum_valid_week,
        :maximum_valid_week, :tag_names,
        article_references_attributes: [:id, :source, :_destroy],
        messages_attributes: [:id, :text, :_destroy]
      ).merge(user_id: current_user.id)
    ]
  end
end
