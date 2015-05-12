class Admin::AuthorialArticlesController < Admin::AdminController
  defaults resource_class: Articles::AuthorialArticle
  load_and_authorize_resource class: 'Articles::AuthorialArticle'

  def table_items
    Articles::AuthorialArticle.includes(:category, :user)
  end

  def create_journalistic_article
    redirect_to(
      articles_journalistic_article: { parent_article_id: params[:id] },
      action: 'new',
      controller: 'journalistic_articles'
    )
  end

  private

  def permitted_params
    permitted = params.permit(
      articles_authorial_article: [
        :id, :text, :title, :summary, :category_id, :user_id,
        :gender, :teenage_pregnancy, :baby_target_type,
        :minimum_valid_week, :maximum_valid_week, { tag_ids: [] },
        article_references_attributes: [:id, :source, :_destroy],
        messages_attributes: [:id, :text, :_destroy]]
    )
    permitted[:articles_authorial_article].merge!(user_id: current_user.id) if permitted.present?
    permitted
  end
end
