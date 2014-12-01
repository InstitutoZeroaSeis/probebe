class ArticlesFinder
  attr_reader :articles
  attr_reader :child

  def initialize(articles, child)
    @child = child
    @articles = articles
  end

  def find_articles_for_child
    articles = filter_by_gender(@articles, child)
    articles = filter_by_life_period(articles)
    filter_by_age(articles)
  end

  protected

  def filter_by_gender(articles, child)
    if @child.gender.present?
      child.gender == 'male' ? articles.send('male_and_both') : articles.send('female_and_both')
    else
      articles
    end
  end

  def filter_by_life_period(articles)
    gender = child.pregnancy? ? 'pregnancy' : 'born'
    articles.select do |article|
      article.send("#{gender}?")
    end
  end

  def filter_by_age(articles)
    articles.to_a.select do |article|
      article.age_valid_for_article?(child.age_in_weeks)
    end
  end

end
