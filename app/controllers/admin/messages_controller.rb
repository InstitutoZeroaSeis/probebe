class Admin::MessagesController < Carnival::BaseAdminController

  private

  def permitted_params
    params.permit(message: [:text, :gender, :teenage_pregnancy, :category])
  end

end