class HomeController < ApplicationController
  def index
    @source = get_source
    if current_user
      @categories_posts = posts_grouped_by_category
    else
      @categories = Category.to_show_in_home
    end
  end

  protected

  def posts_grouped_by_category
    Blog::CategoryGroupedPostsFinder.new.find.map do |category, posts|
      [category, PostPresenter.wrap(posts)]
    end
  end

  def get_source
    return params[:utm_source] if params[:utm_source].present?
    URI(request.referer).path if request.referer.present?
    ''
  end
end
