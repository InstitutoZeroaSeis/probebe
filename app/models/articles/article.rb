class Articles::Article < ActiveRecord::Base
  include Carnival::ModelHelper
    
  belongs_to :category
  belongs_to :user
  has_many :article_references
  has_many :messages, as: :messageable do
    def build(*args, &block)
      item = super(*args, &block)
      item.messageable_type = self.class.name 
      binding.pry;
      item.save!
      item
    end
  end

  has_and_belongs_to_many :tags

  accepts_nested_attributes_for :article_references, allow_destroy: true

  validates_presence_of :text, :summary, :category, :user, :type

end
