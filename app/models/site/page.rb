class Site::Page < ActiveRecord::Base
  include Carnival::ModelHelper
  has_one :menu, class_name: 'Menu'

  def label
    self.title.to_s
  end
end
