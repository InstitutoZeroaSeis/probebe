class Admin::SiteMobileImagesController < Carnival::BaseAdminController
  private

  def permitted_params
    params.permit(site_mobile_image: [:name, :title, :text, :picture_id])
  end
end
