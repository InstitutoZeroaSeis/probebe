class Admin::SearchlogsController < Carnival::BaseAdminController
  private

  def permitted_params
    params.permit(searchlog: [:text, :user_id])
  end
end
