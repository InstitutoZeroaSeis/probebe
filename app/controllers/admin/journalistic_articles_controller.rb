class Admin::JournalisticArticlesController < Admin::AdminController
  defaults resource_class: Articles::JournalisticArticleWithImageCover
  load_and_authorize_resource(
    class: 'Articles::JournalisticArticleWithImageCover'
  )

  layout 'carnival/admin'

  def table_items
    Articles::JournalisticArticle.includes(:category, :user)
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
        redirect_to action: :edit, id: @journalistic_article.id
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
    @journalistic_article = resource
    @journalistic_article.save
  end

  def build_custom_article
    factory = Articles::JournalisticArticleFactory.new(find_authorial_article)
    journalistic_article = factory.build
    if action_name == 'create'
      journalistic_article.assign_attributes(*build_resource_params)
    end
    journalistic_article
  end

  def needs_custom_article?
    %w(new create).include? action_name
  end

  def find_authorial_article
    return unless needs_custom_article?
    id = params[:articles_journalistic_article][:parent_article_id]
    Articles::AuthorialArticle.find(id)
  end

  def build_resource_params
    [
      params.require(:articles_journalistic_article).permit(
        :text, :title, :intro_text, :summary, :category_id, :user_id,
        :original_author_id, :gender, :teenage_pregnancy, :baby_target_type,
        :publishable, :image_cover, :box, :minimum_valid_week,
        :maximum_valid_week, :tag_names,
        article_references_attributes: [:id, :source, :_destroy],
        messages_attributes: [:id, :text, :_destroy]
      ).merge(user_id: current_user.id)
    ]
  end
end
