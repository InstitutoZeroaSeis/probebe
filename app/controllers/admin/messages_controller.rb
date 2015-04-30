class Admin::MessagesController < Admin::AdminController
  load_and_authorize_resource class: 'Message'
  defaults resource_class: Message

  protected

  def table_items
    Message.includes(:messageable)
  end

  def permitted_params
    params.permit(message: [:text])
  end
end
