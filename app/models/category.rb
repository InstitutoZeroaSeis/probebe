class Category < ActiveRecord::Base
  include Carnival::ModelHelper

  belongs_to :parent_category, class_name: "Category", foreign_key: :parent_category_id
  has_many :sub_categories, class_name: "Category", foreign_key: :parent_category_id

end
