class Category < ActiveRecord::Base
  include Carnival::ModelHelper
  [
    :health, :education, :security, :finance, :socio_emotional
  ]

  belongs_to :parent_category, class_name: 'Category'
  has_many :articles, class_name: 'Articles::Article'
  has_many :categories
  has_many :messages

  validates :name, presence: true
  validates :parent_category, presence: true

  has_paper_trail
end
