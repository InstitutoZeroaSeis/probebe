class PostsController < ApplicationController
  layout "blog"

  def index
    @posts = Articles::JournalisticArticle.all
  end

  def show
    @post = Articles::JournalisticArticle.find(params[:id])
  end
end
