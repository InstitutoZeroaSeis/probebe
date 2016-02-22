class PostPresenter < SimpleDelegator
  TEXT_MAXIMUM_LENGTH = 500

  def category_type
    category.parent_category_type
  end

  def post_summary
    intro_text.presence || Nokogiri::HTML(text).text.truncate(TEXT_MAXIMUM_LENGTH)
  end

  def author_name
    original_author.name
  end

  def author_bio
    original_author.bio
  end

  def author_photo_url
    original_author.photo.url(:thumb)
  end

  def related_posts
    @related_posts ||= self.class.wrap(
      Site::RelatedArticleFinder.new(id).find_related
    )
  end

  def pregnancy_or_child_life_period
    born? ? child_life_period : baby_target_type
  end

  def self.wrap(posts)
    posts.map do |post|
      new(post)
    end
  end
end
