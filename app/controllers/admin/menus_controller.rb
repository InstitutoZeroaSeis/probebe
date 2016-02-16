class Admin::MenusController < Carnival::BaseAdminController
  defaults resource_class: Site::Menu
  protected

  def permitted_params
    params.permit(site_menu: [
      :name, :link, :position, :target_blank, :parent_menu_id, :page_id
    ])
  end
end
