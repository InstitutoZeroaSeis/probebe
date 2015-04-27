class PostsController < ApplicationController
  def index
    @presenter = PostsPresenter.new(post_search_params)
  end

  def show
    @tags = Tag.all
    @post = PostPresenter.new(Blog::Post.find(params[:id]))
    render layout: "single-post"
  end

  protected

  def post_search_params
    params.slice(:search, :category, :tag_name, :life_period, :page)
  end
end
