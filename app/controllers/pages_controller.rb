class PagesController < ApplicationController

  def show
    @page = Site::Page.friendly.find params[:id]
  end

end

