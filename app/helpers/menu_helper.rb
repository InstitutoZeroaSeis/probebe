module MenuHelper

  def base_menus
    Site::Menu.base_menus
  end

  def child_menus(parent_id)
    Site::Menu.submenus_from(parent_id)
  end

  def build_link_to(submenu)
    path = submenu.link if submenu.link.present?
    path = page_path(submenu.page) unless submenu.link.present?
    return link_to submenu.name, path, target: "_blank" if submenu.target_blank
    link_to submenu.name, path
  end
end
