class PostsController < ApplicationController
  layout "blog"

  def index
    @posts = Articles::JournalisticArticle.all
  end
end
