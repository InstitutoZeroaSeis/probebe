require 'rails_helper'

RSpec.describe Articles::JournalisticArticle, type: :model do
  it_behaves_like 'a article', :journalistic_article

  it 'is valid with parent_article' do
    article = Articles::JournalisticArticle.new(parent_article: Articles::AuthorialArticle.new)

    article.valid?

    expect(article.errors[:parent_article]).to_not include('não pode ser vazio')
  end

  it 'is invalid with parent_article' do
    article = Articles::JournalisticArticle.new(parent_article: nil)

    article.valid?

    expect(article.errors[:parent_article]).to include('não pode ser vazio')
  end

  it 'is valid with original_author' do
    article = Articles::JournalisticArticle.new(original_author: Authors::Author.new)

    article.valid?

    expect(article.errors[:original_author]).to_not include('não pode ser vazio')
  end

  it 'is invalid with original_author' do
    article = Articles::JournalisticArticle.new(original_author: nil)

    article.valid?

    expect(article.errors[:original_author]).to include('não pode ser vazio')
  end

  it 'is valid with a message smaller than 150 characters' do
    message = Message.new(text: 'Message Text')
    article = Articles::JournalisticArticle.new(messages: [message])

    article.valid?

    expect(article.errors[:base])
      .to_not include('O comprimento máximo de cada mensagem dever ser de até 150 caracteres')
  end

  it 'is invalid with a message greater than 150 characters' do
    message = Message.new(text: 'A' * 152)
    article = Articles::JournalisticArticle.new(messages: [message])

    article.valid?

    expect(article.errors[:base])
      .to include('O comprimento máximo de cada mensagem dever ser de até 150 caracteres')
  end
end
