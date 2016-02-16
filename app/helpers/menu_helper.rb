module MenuHelper

  def base_menus
    Site::Menu.base_menus
  end

  def child_menus(parent_id)
    Site::Menu.submenus_from(parent_id)
  end

  def build_link_to(submenu)
    return link_to submenu.name, page_path(submenu.page), target: "_blank" if submenu.target_blank
    link_to submenu.name, page_path(submenu.page)
  end
end
