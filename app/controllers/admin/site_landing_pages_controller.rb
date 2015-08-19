class Admin::SiteLandingPagesController < Carnival::BaseAdminController
  private

  def permitted_params
    params.permit(site_landing_page: [:title, :text, :picture_id])
  end
end
