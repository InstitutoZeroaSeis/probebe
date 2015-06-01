require 'rails_helper'

RSpec.describe Articles::JournalisticArticle, type: :model do
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

  it 'is expected to update the messages with the correct attributes' do
    article = build(:journalistic_article, :with_message)

    article.save

    article.messages.each do |message|
      expect(article.gender).to eq(message.gender)
      expect(article.teenage_pregnancy).to eq(message.teenage_pregnancy)
      expect(article.baby_target_type).to eq(message.baby_target_type)
      expect(article.minimum_valid_week).to eq(message.minimum_valid_week)
      expect(article.maximum_valid_week).to eq(message.maximum_valid_week)
      expect(article.category).to eq(message.category)
    end
  end
end
