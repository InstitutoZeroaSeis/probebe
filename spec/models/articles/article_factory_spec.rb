require 'rails_helper'

RSpec.describe Articles::ArticleFactory, type: :model do
  it 'builds a non persisted article' do
    factory = Articles::ArticleFactory.new()

    article = factory.build

    expect(article).to_not be_persisted
  end

end
