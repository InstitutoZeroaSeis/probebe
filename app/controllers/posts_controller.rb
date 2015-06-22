class PostsController < ApplicationController
  def index
    @presenter = PostsPresenter.new(post_search_params)
  end

  def show
    @post = PostPresenter.new(Blog::Post.find(params[:id]))
    render layout: 'single-post'
  end

  def raw
    @post = PostPresenter.new(Blog::Post.find(params[:id]))
    render layout: 'raw-single-post'
  end

  protected

  def post_search_params
    params.slice(:search, :category_id, :tag_name, :life_period, :page, :author_id)
  end
end
