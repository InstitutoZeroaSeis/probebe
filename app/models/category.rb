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
  validate :with_children_cannot_have_parent

  enum original_category_type: [
    :health, :education, :security, :finance, :behavior
  ]

  has_paper_trail

  def self.base_categories
    where(parent_category_id: nil)
  end

  def self.original_categories
    where.not(original_category_type: nil).order(:original_category_type)
  end

  def parent_category_type
    parent_category.try(:original_category_type)
  end

  def to_param
    Slug.from_args(id, name)
  end

  protected

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

  def with_children_cannot_have_parent
    return unless categories.any? && parent_category.present?
    errors.add(:parent_category, 'não pode ter mais que dois níveis')
  end
end
