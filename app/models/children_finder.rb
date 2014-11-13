class ChildrenFinder
  attr_reader :article
  attr_reader :children

  def initialize(article, children)
    @children = children
    @article = article
  end

  def find_childrens_for_article
    children = filter_by_gender(@children)
    children = filter_by_life_period(children)
    filter_by_age(children)
  end

  def any_children_found?
    find_childrens_for_article.size > 0
  end

  protected

  def filter_by_gender(children)
    if @article.gender != 'both'
      children.send(@article.gender)
    else
      children
    end
  end

  def filter_by_life_period(children)
    children.select do |child|
      child.send("#{@article.baby_target_type}?")
    end
  end

  def filter_by_age(children)
    children.to_a.select do |child|
      article.age_valid_for_article?(child.age_in_weeks)
    end
  end

end
