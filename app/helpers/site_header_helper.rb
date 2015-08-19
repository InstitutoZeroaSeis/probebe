module SiteHeaderHelper
  def site_header_image
    header = SiteHeader.find_by_path request.path
    if header.present? && header.picture.present?
      header.background_image.url
    else
      'http://s3-us-west-2.amazonaws.com//probebe-uploads/site_banners/background_images/000/000/647/original/banner-5.jpg'
    end
  end
end
