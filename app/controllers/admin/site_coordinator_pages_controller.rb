class Admin::SiteCoordinatorPagesController < Carnival::BaseAdminController
  private

  def permitted_params
    params.permit(site_coordinators_page: [:title, :text])
  end
end
