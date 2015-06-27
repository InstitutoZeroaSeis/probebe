class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data, styles: { content: '1920>', thumb: '118x100#' }, processors: [:cropper, :thumbnail]

  validates_attachment_presence :data
  validates_attachment_size :data, less_than: 2.megabytes
  validates_attachment_content_type :data, content_type: /\Aimage/

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_create :crop_image

  def url_content
    url(:content)
  end


  def crop_image
    puts "CROPIMAGE CROP #{crop_x}"
  end
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
end
