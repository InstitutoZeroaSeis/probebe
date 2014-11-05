class Admin::AuthorialArticlesController < Admin::ArticlesController
  defaults :resource_class => Articles::AuthorialArticle

  layout "carnival/admin"
  
  private
  
  def permitted_params
    permitted = params.permit(articles_authorial_article: [:id, :text, :title, :summary, :category_id, :user_id])
    permitted[:articles_authorial_article].merge!(user_id: current_user.id)
    permitted
  end

end