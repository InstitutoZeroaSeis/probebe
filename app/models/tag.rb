class Tag < ActiveRecord::Base
  include Carnival::ModelHelper

  has_and_belongs_to_many :articles, class_name: 'Articles::Article'
  validates_presence_of :name
  validates_uniqueness_of :name

  def to_param
    Slug.from_args(id, name)
  end

  def articles_count
    articles.size
  end
end
