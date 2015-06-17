class SiteBanner < ActiveRecord::Base
  has_attached_file :background_image, :default_url => "/images/:style/missing.png",
                      styles: { thumb: '118x100#' }
  validates_attachment_content_type :background_image, :content_type => /\Aimage\/.*\Z/

  BANNER_TYPE_ENUM = [:pregnancy, :first_to_fourth, :fifth_to_eighth, :nineth_to_twelfth, :thirteenth_to_eighteenth]
  enum banner_type: BANNER_TYPE_ENUM

  validates :background_image, :banner_type, presence: true
end
