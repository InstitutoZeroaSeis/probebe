class InstitutePage < ActiveRecord::Base
  belongs_to :picture, class_name: 'Ckeditor::Asset'

  def brand_image
    self.picture.data
  end
end
