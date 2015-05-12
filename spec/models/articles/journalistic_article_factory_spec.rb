require 'rails_helper'

RSpec.describe Articles::JournalisticArticleFactory, type: :model do
  it 'builds a non persisted article' do
    authorial_article = build_stubbed(:authorial_article)
    factory = Articles::JournalisticArticleFactory.new(authorial_article)

    journalistic_article = factory.build

    expect(journalistic_article).to_not be_persisted
  end

  it 'builds with the same scalar properties' do
    authorial_article = build_stubbed(:authorial_article)
    factory = Articles::JournalisticArticleFactory.new(authorial_article)

    journalistic_article = factory.build

    Articles::JournalisticArticleFactory::PROPERTIES.each do |property|
      expect(journalistic_article.send(property))
        .to eq(authorial_article.send(property))
    end
  end

  it 'builds new messages with the smae text' do
    authorial_article = build_stubbed(:authorial_article)
    factory = Articles::JournalisticArticleFactory.new(authorial_article)

    journalistic_article = factory.build

    expect(authorial_article.messages.map(&:name))
      .to match_array(journalistic_article.messages.map(&:name))
  end
end
