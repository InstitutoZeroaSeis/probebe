require 'rails_helper'

RSpec.describe ArticlesMatcher, :type => :model do
  context "with child born, male and five months old" do
    context "and articles that applicable for that child" do
      subject { ArticlesMatcher.new(Articles::JournalisticArticle.all, @child, @system_date).find_articles_for_child }
      before { @child = create(:child, birth_date: 5.months.ago) }
      before { @article1 = create(:journalistic_article, :male, maximum_valid_week: 22, baby_target_type: 'born') }
      before { @article2 = create(:journalistic_article, :both, minimum_valid_week: 10, baby_target_type: 'born') }
      before { @system_date = SystemDate.new }
      it { is_expected.to match_array([@article1, @article2]) }
    end
  end

  context "with child born, female and half an year old" do
    context "return none applicable articles for that child" do
      subject { ArticlesMatcher.new(Articles::JournalisticArticle.all, @child, @system_date).find_articles_for_child }
      before { @child = create(:child, birth_date: 18.months.ago) }
      before { @article1 = create(:journalistic_article, :female, minimum_valid_week: 12, maximum_valid_week: 22, baby_target_type: 'born') }
      before { @article2 = create(:journalistic_article, :both, maximum_valid_week: 10, baby_target_type: 'born') }
      before { @system_date = SystemDate.new }
      it { is_expected.to be_empty }
    end
  end

  context "with pregnancy child, no gender specified, pregnancy for about 5 months" do
    context "and articles that applicable for that child " do
      subject { ArticlesMatcher.new(Articles::JournalisticArticle.all, @child, @system_date).find_articles_for_child }
      before { @child = create(:child, birth_date: 7.months.from_now) }
      before { @article1 = create(:journalistic_article, :male, maximum_valid_week: 22, baby_target_type: 'pregnancy') }
      before { @article2 = create(:journalistic_article, :male, minimum_valid_week: 10, maximum_valid_week: 25, baby_target_type: 'pregnancy') }
      before { @system_date = SystemDate.new }
      it { is_expected.to match_array([@article1, @article2]) }
    end
  end

  context "with pregnancy child, no gender specified, pregnancy for about 2 months" do
    context "and 4 articles that, the two of them are applicable" do
      subject { ArticlesMatcher.new(Articles::JournalisticArticle.all, @child, @system_date).find_articles_for_child }
      before { @child = create(:child, birth_date: 7.months.from_now) }
      before { @article1 = create(:journalistic_article, :male, maximum_valid_week: 14, baby_target_type: 'pregnancy') }
      before { @article2 = create(:journalistic_article, :male, minimum_valid_week: 3, baby_target_type: 'pregnancy') }
      before { @article3 = create(:journalistic_article, :both, minimum_valid_week: 16, baby_target_type: 'pregnancy') }
      before { @article4 = create(:journalistic_article, :both, minimum_valid_week: 10, baby_target_type: 'born') }
      before { @system_date = SystemDate.new }
      it { is_expected.to match_array([@article1, @article2]) }
    end
  end

  context "with articles, one is ending valiates maximum weeks" do
    context "order them by priority of ending valid week" do
      subject { ArticlesMatcher.new(Articles::JournalisticArticle.all, @child, @system_date).find_articles_for_child }
      before { @child = create(:child, birth_date: 7.months.from_now) }
      before { @article1 = create(:journalistic_article, :male, minimum_valid_week: 9, maximum_valid_week: 13, baby_target_type: 'pregnancy') }
      before { @article2 = create(:journalistic_article, :male, minimum_valid_week: 7, maximum_valid_week: 11, baby_target_type: 'pregnancy') }
      before { @article3 = create(:journalistic_article, :male, minimum_valid_week: 7, maximum_valid_week: 12, baby_target_type: 'pregnancy') }
      before { @system_date = SystemDate.new }
      it { is_expected.to match_array([@article2, @article3, @article1]) }
    end
  end

  context "with articles and system date with date different from today" do
    context "order them by priority of ending valid week" do
      subject { ArticlesMatcher.new(Articles::JournalisticArticle.all, @child, @system_date).find_articles_for_child }
      before { @child = create(:child, birth_date: 7.months.from_now) }
      before { @article1 = create(:journalistic_article, :male, minimum_valid_week: 9, maximum_valid_week: 20, baby_target_type: 'pregnancy') }
      before { @article2 = create(:journalistic_article, :male, minimum_valid_week: 7, maximum_valid_week: 17, baby_target_type: 'pregnancy') }
      before { @article3 = create(:journalistic_article, :male, minimum_valid_week: 7, baby_target_type: 'pregnancy') }
      before { @system_date = SystemDate.new(5.weeks.from_now.to_date.to_s) }
      it { is_expected.to match_array([@article2, @article1, @article3]) }
    end
  end



end
