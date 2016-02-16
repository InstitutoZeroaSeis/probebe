
class Site::Menu < ActiveRecord::Base
  include Carnival::ModelHelper
  belongs_to :parent_menu, class_name: 'Menu'
  belongs_to :page, class_name: 'Page'
  has_many :submenus, foreign_key: :parent_menu_id

  validates :name, :position, presence: true
  validate :page_or_link

  def self.base_menus
    where(parent_menu_id: nil).order(:position)
  end

  def self.submenus_from(parent_id)
    where(parent_menu_id: parent_id).order(:position)
  end

  def page_or_link
    if !self.link.present? && !self.page.present? && self.parent_menu.present?
      errors.add(:base, :has_no_link_or_page)
      return false
    end
  end

end
