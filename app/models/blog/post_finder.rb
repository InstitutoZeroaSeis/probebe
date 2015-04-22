module Blog
  class Blog::PostFinder
    def initialize(search, category, tag_name)
      @search = search
      @category = category
      @tag_name = tag_name
    end

    def find
      ordered_posts = Blog::PostOrderByCreation.new(Blog::Post.all).sort
      publishable_posts = Blog::PostPublishableFinder.new(ordered_posts).find
      posts_by_search_name = Blog::PostSearchTermFinder.new(@search, publishable_posts).find
      posts_by_category = Blog::PostByCategoryFinder.new(@category, posts_by_search_name).find
      posts_by_tag = Blog::PostByTagFinder.new(@tag_name, posts_by_category).find
    end
  end
end
