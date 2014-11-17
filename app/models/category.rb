class Category < ActiveRecord::Base
  include Carnival::ModelHelper
  MAXIMUM_HIERARCHY_SIZE = 2

  belongs_to :parent_category, class_name: "Category", foreign_key: :parent_category_id
  has_many :sub_categories, class_name: "Category", foreign_key: :parent_category_id
  has_many :messages
  has_many :articles, class_name: "Articles::Article"

  validates_presence_of :name
  validate :maximum_hierarchy_level
  validate :hierarchy_has_no_cycles
  before_destroy :check_has_no_child_categories

  scope :super_categories, -> { where(parent_category_id: nil)}
  scope :sub_categories, -> { where.not(parent_category_id: nil)}

  def maximum_hierarchy_level
    hierarchy_level_count = 1
    current_category = self
    hierarchy_level_count += 1 while (current_category = current_category.parent_category) != nil and hierarchy_level_count <= MAXIMUM_HIERARCHY_SIZE
    if hierarchy_level_count > MAXIMUM_HIERARCHY_SIZE
      errors.add(:parent_category, I18n.t("activerecord.errors.models.category.attributes.parent_category.hierarchy_too_big"))
    end
  end

  def hierarchy_has_no_cycles
    slow = fast = self.get_parent_category(self)
    while has_not_find_cycle(slow, fast) do
      slow = slow.get_parent_category(self)
      fast = fast.get_parent_category(self).get_parent_category(self)
      if slow == fast
        errors.add(:parent_category, I18n.t("activerecord.errors.models.category.attributes.parent_category.hierarchy_has_cycles"))
        break
      end
    end
  end

  def has_not_find_cycle(slow, fast)
    slow != nil && fast != nil && fast.get_parent_category(self) != nil
  end

  def get_parent_category(current_category)
    if self.parent_category and self.parent_category.id == current_category.id
      current_category
    else
      self.parent_category
    end
  end

  def check_has_no_child_categories
    if self.class.where(parent_category_id: self.id).count > 0
      errors.add(:base, I18n.t("activerecord.errors.models.category.attributes.base.has_child_categories"))
      return false
    end
  end
end
