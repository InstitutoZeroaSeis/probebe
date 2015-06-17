class Admin::SiteBannersController < Carnival::BaseAdminController
  private

  def permitted_params
    params.permit(site_banner: [:banner_type, :title, :text, :background_image])
  end
end
