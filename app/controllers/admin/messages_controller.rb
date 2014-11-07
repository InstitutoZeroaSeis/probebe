class Admin::MessagesController < Carnival::BaseAdminController

  before_filter :deny_site_user_access_on_admin
  before_filter :deny_site_user_access_on_admin

  private

  def permitted_params
    params.permit(message: [:text, :gender, :teenage_pregnancy, :category_id, :baby_target_type, :minimum_valid_week, :maximum_valid_week])
  end

end
