class ProfileFinder
  attr_reader :article

  def initialize(article)
    @article = article
    @scope = article.baby_target_type == 'pregnancy' ? 'pregnant' : 'mother'
  end

  def find_profiles_by_article
    find_profiles_by_children
  end

  protected

  def find_profiles_by_children
    Profile.select do |profile|
      children_finder = ChildrenFinder.new(article, profile.children)
      children_finder.any_children_found?
    end
  end

end
