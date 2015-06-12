module ArticleHelper

  def show_image_class
    "hide" if @model.cover.blank?
  end

end
