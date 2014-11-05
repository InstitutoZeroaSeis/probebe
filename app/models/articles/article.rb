class Articles::Article < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :category
  validates_presence_of :text, :summary, :category, :user, :type

end
