class Category < ActiveRecord::Base
  include Carnival::ModelHelper

  belongs_to :parent_category, class_name: 'Category'
  has_many :articles, class_name: 'Articles::Article'
  has_many :categories, foreign_key: :parent_category_id
  has_many :messages

  validates :name, presence: true
  validates :name, uniqueness: true
  validate :parent_category_is_not_equals_self
  validate :parent_category_is_at_most_two_levels_deep
  validate :parent_category_cannot_be_a_children
  validate :with_children_cannot_have_parent

  before_destroy :check_for_articles

  enum original_category_type: [
    :health, :education, :security, :finance, :behavior
  ]

  has_paper_trail

  def subcategory?
    parent_category.present?
  end

  def self.base_categories
    where(parent_category_id: nil)
  end

  def self.sub_categories
    where.not(parent_category_id: nil)
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

  def check_for_articles
    return true if articles.empty?
    errors.add(:base, :has_articles)
    false
  end

  def parent_category_is_not_equals_self
    return unless parent_category == self
    errors.add(:parent_category, :equals_self)
  end

  def parent_category_is_at_most_two_levels_deep
    return unless parent_category.try(:parent_category)
    errors.add(:parent_category, :more_than_two_levels_deep)
  end

  def parent_category_cannot_be_a_children
    return unless parent_category.try(:parent_category) == self
    errors.add(:parent_category, :equals_sub_category)
  end

  def with_children_cannot_have_parent
    return unless categories.any? && parent_category.present?
    errors.add(:parent_category, :children_with_parent)
  end
end
