class Admin::GalleryImagesController < ApplicationController

  def index
    list = Ckeditor::Picture.all
    respond_to do |format|
      format.json { render json: list }
    end
  end

end

