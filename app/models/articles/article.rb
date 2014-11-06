class Articles::Article < ActiveRecord::Base
  include Carnival::ModelHelper
    
  belongs_to :user
  belongs_to :category
  has_and_belongs_to_many :tags

  validates_presence_of :text, :summary, :category, :user, :type
  

end
