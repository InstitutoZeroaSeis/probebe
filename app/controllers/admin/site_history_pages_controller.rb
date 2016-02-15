class Admin::SiteHistoryPagesController < Carnival::BaseAdminController
  private

  def permitted_params
    params.permit(site_history_page: [:title, :text, :picture_id])
  end
end
