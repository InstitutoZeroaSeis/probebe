class Articles::Article < ActiveRecord::Base
  include Carnival::ModelHelper
    
  belongs_to :category
  belongs_to :user
  has_many :article_references
  has_and_belongs_to_many :tags

  accepts_nested_attributes_for :article_references

  validates_presence_of :text, :summary, :category, :user, :type

end
