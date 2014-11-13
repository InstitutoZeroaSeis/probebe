module Articles
  class Article < ActiveRecord::Base
    include Carnival::ModelHelper

    belongs_to :category
    belongs_to :user
    belongs_to :original_author, class_name: "User"
    has_many :article_references


    has_and_belongs_to_many :tags

    accepts_nested_attributes_for :article_references, allow_destroy: true
    accepts_nested_attributes_for :tags, allow_destroy: false

    validates_presence_of :text, :title, :category, :user, :type

  end
end
