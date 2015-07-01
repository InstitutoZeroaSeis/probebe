class Admin::CmsImagesController < Ckeditor::PicturesController
  def create
    @picture = picture_model
    respond_with_asset(@picture)
  end


  private

  def picture_model
    type = params[:type]
    return Ckeditor::SiteBannersImage.new if type == 'site_banner'
    return Ckeditor::CategoryImage.new if type == 'category'
    return Ckeditor::ArticleCoverImage.new if type == 'article_cover'
    return Ckeditor::ArticleThumbImage.new if type == 'article_thumb'
    Ckeditor::Picture
  end
end
