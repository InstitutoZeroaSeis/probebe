class Site::Page < ActiveRecord::Base
  extend FriendlyId

  include Carnival::ModelHelper
  has_one :menu, class_name: 'Menu'
  friendly_id :title, use: :slugged

  validates :title, :text, presence: true

  def label
    self.title
  end
end
