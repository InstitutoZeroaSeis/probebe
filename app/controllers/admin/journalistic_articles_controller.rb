class Admin::JournalisticArticlesController < Carnival::BaseAdminController
  before_filter :authenticate_user!
  defaults :resource_class => Articles::JournalisticArticle

  before_filter :deny_site_user_access_on_admin
  load_and_authorize_resource class: 'Articles::JournalisticArticle'

  layout "carnival/admin"


  def build_resource
    if action_name == "new"
      new_journalist_article_from_authorial_article(params[:id], include_tags: true)
    elsif action_name == "create"
      new_journalist_article_from_authorial_article(params[:articles_journalistic_article][:parent_article_id]).tap do |article|
        article.assign_attributes(permitted_params[:articles_journalistic_article])
      end
    else
      super
    end
  end

  def new_journalist_article_from_authorial_article(authorial_article_id, include_tags: false)
    authorial_article = Articles::AuthorialArticle.find(authorial_article_id)
    @journalistic_article = Articles::JournalisticArticle.new do |a|
      a.baby_target_type = authorial_article.baby_target_type
      a.category_id = authorial_article.category_id
      a.gender = authorial_article.gender
      a.minimum_valid_week = authorial_article.minimum_valid_week
      a.maximum_valid_week = authorial_article.maximum_valid_week
      a.original_author = authorial_article.user
      a.parent_article = authorial_article
      a.tags = authorial_article.tags if include_tags
      a.teenage_pregnancy = authorial_article.teenage_pregnancy
    end
  end

  private

  def permitted_params
    permitted = params.permit(articles_journalistic_article:
                              [:id, :text, :title, :summary, :category_id, :user_id,
                              :gender, :teenage_pregnancy, :baby_target_type, :publishable,
                              :minimum_valid_week, :maximum_valid_week, {tag_ids: []},
                              article_references_attributes:[:id, :source, :_destroy],
                              messages_attributes:[:id, :text, :_destroy]])
    permitted[:articles_journalistic_article].merge!(user_id: current_user.id) if permitted.present?
    permitted
  end

end
