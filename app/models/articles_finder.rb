class ArticlesFinder
  attr_reader :articles
  attr_reader :child
  attr_reader :system_date

  def initialize(articles, child, system_date)
    @child = child
    @articles = articles
    @system_date = system_date
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
    gender = child.pregnancy?(@system_date) ? 'pregnancy' : 'born'
    articles.select do |article|
      article.send("#{gender}?")
    end
  end

  def filter_by_age(articles)
    age_in_weeks = child.age_in_weeks(@system_date)
    articles.to_a.select do |article|
      article.age_valid_for_article?(age_in_weeks)
    end
  end

end
