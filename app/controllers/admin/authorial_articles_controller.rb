class Admin::AuthorialArticlesController < Carnival::BaseAdminController
  defaults :resource_class => Articles::AuthorialArticle

  before_filter :deny_site_user_access_on_admin
  load_and_authorize_resource class: 'Articles::AuthorialArticle'

  layout "carnival/admin"

  def create_journalistic_article
    redirect_to controller: 'journalistic_articles', action: 'new',  id: params[:id]
  end

  private

  def permitted_params
    permitted = params.permit(articles_authorial_article:
                              [:id, :text, :title, :summary, :category_id,:user_id, {tag_ids: []},
                              article_reference_attributes:[:id, :source, :_destroy],
                              messages_attributes:[:id, :text, :gender, :teenage_pregnancy, :category_id, :baby_target_type, :minimum_valid_week, :maximum_valid_week, :_destroy]])

    permitted[:articles_authorial_article].merge!(user_id: current_user.id) if permitted.present?
    permitted
  end

end
