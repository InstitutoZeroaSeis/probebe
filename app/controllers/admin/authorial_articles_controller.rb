class Admin::AuthorialArticlesController < Carnival::BaseAdminController
  defaults :resource_class => Articles::AuthorialArticle

  layout "carnival/admin"
  
  private
  
  def permitted_params
    permitted = params.permit(articles_authorial_article: [:id, :text, :title, :summary, :category_id, :user_id, {tag_ids: []}])
      permitted[:articles_authorial_article].merge!(user_id: current_user.id) if permitted.present?
      permitted
  end

end