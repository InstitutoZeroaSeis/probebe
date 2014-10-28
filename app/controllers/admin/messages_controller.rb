class Admin::MessagesController < Carnival::BaseAdminController

  private

  def permitted_params
    params.permit(message: [:text, :gender, :teenage_pregnancy, :category_id, :baby_target_type])
  end

end
