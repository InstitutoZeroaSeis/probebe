class Admin::CmsImagesController < Ckeditor::PicturesController
  def create
    @picture = SiteBannersImage.new
    respond_with_asset(@picture)
  end
end
