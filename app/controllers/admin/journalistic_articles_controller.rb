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
        article.assign_attributes(permitted_params)
      end
    else
      super
    end
  end

  def new_journalist_article_from_authorial_article(authorial_article_id, include_tags: false)
    authorial_article = Articles::AuthorialArticle.find(authorial_article_id)

    @journalistic_article = Articles::JournalisticArticle.new do |a|
      a.parent_article = authorial_article
      a.category_id = authorial_article.category_id
      a.original_author = authorial_article.user
      a.tags = authorial_article.tags if include_tags
    end
  end

  private

  def permitted_params
    article_params = params[:articles_journalistic_article]
    article_params = article_params ? article_params.permit([:text, :title, :summary, {tag_ids:[]},
                                            article_references_attributes:[:id, :source, :_destroy],
                                            messages_attributes: [:id, :text, :_destroy]]) : {}

    article_params.merge!(user_id: current_user.id) if article_params
    article_params
  end

end
