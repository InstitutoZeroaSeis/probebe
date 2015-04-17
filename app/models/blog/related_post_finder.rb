module Blog
  class RelatedPostFinder
    NUMBER_NECESSARY_OF_RELATED_POST = 3

    def initialize(post_id)
      @post_id = post_id
    end

    def find_related
      post = Articles::JournalisticArticle.find(@post_id)
      ids = find_related_post_ids(post)
      Articles::JournalisticArticle.where(id: ids)
    end

    def find_related_post_ids(post)
      tags_name = tag_names(post)
      select_randomly(Articles::JournalisticArticle.by_tag(tags_name).publishable.pluck(:id))
    end

    def tag_names(post)
      post.tags.map(&:name)
    end

    def select_randomly(post_ids)
      post_ids.sample(NUMBER_NECESSARY_OF_RELATED_POST)
    end
  end
end
