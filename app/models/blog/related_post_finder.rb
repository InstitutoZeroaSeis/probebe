module Blog
  class RelatedPostFinder
    NUMBER_NECESSARY_OF_RELATED_POST = 3

    def initialize(post_id)
      @post_id = post_id
    end

    def find_related
      post = Blog::Post.find(@post_id)
      ids = find_related_post_ids(post)
      Blog::Post.where(id: ids)
    end

    protected

    def find_related_post_ids(post)
      tags_name = post.tags.map(&:name)
      select_randomly(publishable_and_by_tag_posts(tags_name).pluck(:id))
    end

    def select_randomly(post_ids)
      post_ids.reject do |id|
        id == @post_id
      end.sample(NUMBER_NECESSARY_OF_RELATED_POST)
    end

    def publishable_and_by_tag_posts(tags_name)
      post_by_tag = Blog::PostByTagFinder.new(tags_name, Blog::Post).find
      Blog::PostPublishableFinder.new(post_by_tag).find
    end
  end
end
