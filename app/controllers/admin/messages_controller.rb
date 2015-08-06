class Admin::MessagesController < Admin::AdminController
  load_and_authorize_resource class: 'Message'
  defaults resource_class: Message

  def edit
    redirect_to edit_admin_article_path Articles::Article.find(@message.article_id)
  end

  protected

  def table_items
    Message.joins(:article)
  end

  def permitted_params
    params.permit(message: [:text])
  end
end
