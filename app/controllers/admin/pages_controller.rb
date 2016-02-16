class Admin::PagesController < Carnival::BaseAdminController
  defaults resource_class: Site::Page
  protected

  def permitted_params
    params.permit(site_page: [
      :title, :subtitle, :text
    ])
  end
end
