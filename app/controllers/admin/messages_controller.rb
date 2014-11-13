class Admin::MessagesController < Carnival::BaseAdminController
  before_filter :authenticate_user!

  before_filter :deny_site_user_access_on_admin
  before_filter :deny_site_user_access_on_admin
  load_and_authorize_resource class: 'Message'

  private

  def permitted_params
    params.permit(message: [:text, :gender, :teenage_pregnancy, :category_id, :baby_target_type, :minimum_valid_week, :maximum_valid_week])
  end

end
