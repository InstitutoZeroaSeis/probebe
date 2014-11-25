class Admin::MessagesController < Admin::AdminController
  load_and_authorize_resource class: 'Message'

  private

  def permitted_params
    params.permit(message: [:text])
  end

end
