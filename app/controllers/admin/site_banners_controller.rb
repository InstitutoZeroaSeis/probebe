class Admin::SiteBannersController < Carnival::BaseAdminController
  private

  def permitted_params
    params.permit(site_banner: [:name, :title, :text, :background_image])
  end
end
