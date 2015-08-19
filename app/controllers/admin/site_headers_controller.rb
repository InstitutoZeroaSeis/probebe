class Admin::SiteHeadersController < Carnival::BaseAdminController
  private

  def permitted_params
    params.permit(site_header: [:path, :picture_id])
  end
end
