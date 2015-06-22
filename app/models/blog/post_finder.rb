module Blog
  class PostFinder
    def initialize(options = {})
      @search = options[:search]
      @category_id = options[:category_id]
      @tag_name = options[:tag_name]
      @life_period = options[:life_period]
      @author_id = options[:author_id]
    end

    def find
      ordered_posts = Blog::PostOrderByCreation.new(Blog::Post.all).sort
      posts_by_search_name = Blog::PostSearchTermFinder.new(@search, ordered_posts).find
      posts_by_category = Blog::PostByCategoryFinder.new(@category_id, posts_by_search_name).find
      posts_by_tag = Blog::PostByTagFinder.new(@tag_name, posts_by_category).find
      posts_by_author = Blog::PostByAuthorFinder.new(@author_id, posts_by_tag).find
      Blog::PostByChildLifePeriodFinder.new(@life_period, posts_by_author).find
    end
  end
end
