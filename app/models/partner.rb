class Partner < ActiveRecord::Base
  belongs_to :picture, class_name: 'Ckeditor::Asset'
  belongs_to :logo, class_name: 'Ckeditor::Asset'

  def background_image
    self.picture.data
  end
end
