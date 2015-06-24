class SiteBanner < ActiveRecord::Base
  belongs_to :picture, class_name: 'Ckeditor::Picture'
end
