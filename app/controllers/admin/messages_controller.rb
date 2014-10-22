class Admin::MessagesController < Carnival::BaseAdminController

  private

  def permitted_params
    params.permit(message: [:title, :text, :gender, :teenage_pregnancy])
  end

end