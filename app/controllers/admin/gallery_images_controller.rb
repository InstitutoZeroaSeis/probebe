class Admin::GalleryImagesController < ApplicationController

  def index
    list = []
    Ckeditor::Asset.all.each do |pic|
      list << pic if pic.created_at.present?
    end


    respond_to do |format|
      format.json { render json: list }
    end
  end

end

