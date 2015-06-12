class Admin::ArticlesController < Admin::AdminController
  defaults resource_class: Articles::ArticleWithImageCover
  load_and_authorize_resource(
    class: 'Articles::ArticleWithImageCover'
  )

  layout 'carnival/admin'

  def table_items
    Articles::Article.includes(:category, :user)
  end

  def build_resource
    needs_custom_article? ? build_custom_article : super
  end

  def show
    redirect_to post_path(params[:id])
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

  def build_custom_article
    factory = Articles::ArticleFactory.new()
    factory.build.tap do |article|
      if action_name == 'create'
        article.assign_attributes(*build_resource_params)
      end
    end
  end

  def needs_custom_article?
    %w(new create).include? action_name
  end

  def build_resource_params
    [
      params.require(:articles_article).permit(
        :text, :title, :intro_text, :summary, :category_id, :user_id,
        :original_author_id, :gender, :teenage_pregnancy, :baby_target_type,
        :publishable, :cover, :thumb_image_cover, :box, :minimum_valid_week,
        :maximum_valid_week, :tag_names,
        article_references_attributes: [:id, :source, :_destroy],
        messages_attributes: [:id, :text, :_destroy]
      ).merge(user_id: current_user.id)
    ]
  end
end
