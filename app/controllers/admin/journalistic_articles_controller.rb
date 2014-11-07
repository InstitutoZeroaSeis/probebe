class Admin::JournalisticArticlesController < Carnival::BaseAdminController
  defaults :resource_class => Articles::JournalisticArticle

  layout "carnival/admin"
  
  private
  
  def permitted_params
    permitted = params.permit(articles_journalistic_article: [:id, :text, :title, :summary, :category_id, :user_id, :parent_article_id, {tag_ids: []}])
    permitted[:articles_journalistic_article].merge!(user_id: current_user.id) if permitted.present?
    permitted
  end

end