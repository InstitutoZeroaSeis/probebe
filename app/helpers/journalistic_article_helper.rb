module JournalisticArticleHelper

  def show_image_class
    "hide" if @model.image_cover.blank? 
  end

end