class SiteBanner < ActiveRecord::Base
  has_attached_file :background_image, :default_url => "/images/:style/missing.png",
                      styles: { thumb: '118x100#' }
  validates_attachment_content_type :background_image, :content_type => /\Aimage\/.*\Z/

  validates :background_image, :position, :name,  presence: true

end
