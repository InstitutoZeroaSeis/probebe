class Category < ActiveRecord::Base
  include Carnival::ModelHelper
  PARENT_CATEGORY_ENUM = [:health, :education, :security, :finance, :socio_emotional]

  has_many :messages
  has_many :articles, class_name: "Articles::Article"

  validates_presence_of :name, :parent_category

  enum parent_category: PARENT_CATEGORY_ENUM

  has_paper_trail

end
