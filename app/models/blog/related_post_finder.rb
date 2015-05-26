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
      tag_ids = post.tags.map(&:id)
      select_randomly(posts_by_tags(tag_ids).pluck(:id))
    end

    def select_randomly(post_ids)
      post_ids.reject do |id|
        id == @post_id
      end.sample(NUMBER_NECESSARY_OF_RELATED_POST)
    end

    def posts_by_tags(tags_name)
      Blog::PostByTagFinder.new(tags_name, Blog::Post).find
    end
  end
end
