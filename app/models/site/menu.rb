class Site::Menu < ActiveRecord::Base
  include Carnival::ModelHelper
  belongs_to :parent_menu, class_name: 'Menu'
  belongs_to :page, class_name: 'Page'
  has_many :submenus, foreign_key: :parent_menu_id

  def self.base_menus
    where(parent_menu_id: nil).order(:position)
  end
end
