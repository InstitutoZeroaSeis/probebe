class Admin::PartnersController < Carnival::BaseAdminController
  private

  def permitted_params
    params.permit(partner: [:name, :logo_id, :picture_id])
  end
end
