class PostPresenter < SimpleDelegator
  TEXT_MAXIMUM_LENGTH = 500

  def category_type
    category.parent_category_type
  end

  def post_summary
    summary.presence || Nokogiri::HTML(text).text.truncate(TEXT_MAXIMUM_LENGTH)
  end

  def titleized_title
    title.titleize
  end

  def author_name
    profile.name
  end

  def author_photo_url
    profile.avatar_url
  end

  def related_posts
    @related_posts ||= self.class.wrap(
      Blog::RelatedPostFinder.new(id).find_related
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
