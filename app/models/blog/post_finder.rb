module Blog
  class PostFinder
    def initialize(options = {})
      @search = options[:search]
      @category = options[:category]
      @tag_name = options[:tag_name]
      @life_period = options[:life_period]
    end

    def find
      ordered_posts = Blog::PostOrderByCreation.new(Blog::Post.all).sort
      publishable_posts = Blog::PostPublishableFinder.new(ordered_posts).find
      posts_by_search_name = Blog::PostSearchTermFinder.new(@search, publishable_posts).find
      posts_by_category = Blog::PostByCategoryFinder.new(@category, posts_by_search_name).find
      posts_by_tag = Blog::PostByTagFinder.new(@tag_name, posts_by_category).find
      posts_by_child_life_period = Blog::PostByChildLifePeriodFinder.new(@life_period, posts_by_tag).find
    end
  end
end
