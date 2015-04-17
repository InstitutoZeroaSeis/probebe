class Admin::JournalisticArticlesController < Admin::AdminController
  defaults :resource_class => Articles::JournalisticArticle
  load_and_authorize_resource class: 'Articles::JournalisticArticle'

  layout "carnival/admin"

  def table_items
    Articles::JournalisticArticle.includes(:category, :user)
  end

  def build_resource
    if action_name == "new"
      authorial_article = find_authorial_article(params[:id])
      Articles::JournalisticArticleFactory.from_authorial_article authorial_article
    elsif action_name == "create"
      authorial_article = find_authorial_article(params[:articles_journalistic_article][:parent_article_id])
      Articles::JournalisticArticleFactory.from_authorial_article(authorial_article).tap do |article|
        article.assign_attributes journalistic_article_attributes
      end
    else
      super
    end
  end

  private

  def find_authorial_article(id)
    Articles::AuthorialArticle.find(id)
  end

  def journalistic_article_attributes
    permitted_params[:articles_journalistic_article]
  end

  def permitted_params
    permitted = params.permit(articles_journalistic_article:
                              [:id, :text, :title, :summary, :category_id, :user_id, :original_author_id,
                              :gender, :teenage_pregnancy, :baby_target_type, :publishable, :show_author,
                              :box, :minimum_valid_week, :maximum_valid_week, {tag_ids: []},
                              article_references_attributes:[:id, :source, :_destroy],
                              messages_attributes:[:id, :text, :_destroy]])
    permitted[:articles_journalistic_article].merge!(user_id: current_user.id) if permitted.present?
    permitted
  end

end
