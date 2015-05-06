class Category < ActiveRecord::Base
  include Carnival::ModelHelper

  belongs_to :parent_category, class_name: 'Category'
  has_many :articles, class_name: 'Articles::Article'
  has_many :categories, foreign_key: :parent_category_id
  has_many :messages

  validates :name, presence: true
  validate :parent_category_is_not_equals_self
  validate :parent_category_is_at_most_two_levels_deep
  validate :parent_category_cannot_be_a_children

  has_paper_trail

  protected

  def self.base_categories
    where(parent_category_id: nil)
  end

  def parent_category_is_not_equals_self
    return unless parent_category == self
    errors.add(:parent_category, 'não pode ser igual a categoria')
  end

  def parent_category_is_at_most_two_levels_deep
    return unless parent_category.try(:parent_category)
    errors.add(:parent_category, 'não pode ter mais que dois níveis')
  end

  def parent_category_cannot_be_a_children
    return unless parent_category.try(:parent_category) == self
    errors.add(:parent_category, 'não pode ser igual a uma subcategoria')
  end
end
