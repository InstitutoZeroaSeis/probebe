class Admin::MessagesController < Admin::AdminController
  load_and_authorize_resource class: 'Message'
  defaults resource_class: Message

  def edit
    redirect_to polymorphic_url(
      Articles::Article.find(@message.messageable_id), action: :edit
    )
  end

  protected

  def table_items
    Message.includes(:messageable)
  end

  def permitted_params
    params.permit(message: [:text])
  end
end
