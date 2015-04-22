class Admin::JournalisticArticlesController < Admin::AdminController
  defaults resource_class: Articles::JournalisticArticleWithCover
  load_and_authorize_resource class: 'Articles::JournalisticArticleWithCover'

  layout "carnival/admin"

  def table_items
    Articles::JournalisticArticle.includes(:category, :user)
  end

  def build_resource
    if action_name == 'new'
      authorial_article = find_authorial_article(params[:id])
      Articles::JournalisticArticleFactory.from_authorial_article authorial_article
    elsif action_name == 'create'
      authorial_article = find_authorial_article(params[:articles_journalistic_article][:parent_article_id])
      Articles::JournalisticArticleFactory.from_authorial_article(authorial_article).tap do |article|
        article.assign_attributes *build_resource_params
      end
    else
      super
    end
  end

  private

  def find_authorial_article(id)
    Articles::AuthorialArticle.find(id)
  end

  def build_resource_params
    [
      params.require(:articles_journalistic_article).permit(
        :id, :text, :title, :summary, :category_id, :user_id, :original_author_id,
        :gender, :teenage_pregnancy, :baby_target_type, :publishable, :image_cover,
        :box, :minimum_valid_week, :maximum_valid_week, {tag_ids: []},
        article_references_attributes:[:id, :source, :_destroy],
        messages_attributes:[:id, :text, :_destroy]
      ).merge(user_id: current_user.id)
    ]
  end
end
