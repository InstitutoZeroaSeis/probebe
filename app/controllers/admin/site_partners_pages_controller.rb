class Admin::SitePartnersPagesController < Carnival::BaseAdminController
  private

  def permitted_params
    params.permit(site_partners_page: [:title, :text])
  end
end
