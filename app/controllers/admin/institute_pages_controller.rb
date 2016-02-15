class Admin::InstitutePagesController < Carnival::BaseAdminController
  private

  def permitted_params
    params.permit(institute_page: [:title, :text, :picture_id])
  end
end
