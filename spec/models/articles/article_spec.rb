require 'rails_helper'

RSpec.describe Articles::Article, type: :model do
  it_behaves_like 'a article', :article

  context 'without text' do
    subject { build_stubbed :article, :without_text }
    it { is_expected.to be_invalid }
  end

  context 'without title' do
    subject { build_stubbed :article, :without_title }
    it { is_expected.to be_invalid }
  end

  context 'without category' do
    subject { build_stubbed :article, :without_category }
    it { is_expected.to be_invalid }
  end

  context 'without user' do
    subject { build_stubbed :article, :without_user }
    it { is_expected.to be_invalid }
  end

  context 'without minimum and maximum valid week' do
    subject { build_stubbed(:article, :without_minimum_valid_week, :without_maximum_valid_week) }
    it { is_expected.to be_invalid }
  end

  context 'minimum less than maximum' do
    subject { build_stubbed(:article, minimum_valid_week: 5, maximum_valid_week: 10) }
    it { is_expected.to be_valid }
  end

  context 'minimum higher than maximum' do
    subject { build_stubbed(:article, minimum_valid_week: 12, maximum_valid_week: 10) }
    it { is_expected.to be_invalid }
  end

  it 'allows only categories that have a parent' do
    category = Category.new
    article = Articles::Article.new(category: category)

    article.valid?

    expect(article.errors[:category]).to include('deve ser uma subcategoria')
  end

  it 'is valid with original_author' do
    article = Articles::Article.new(original_author: Authors::Author.new)

    article.valid?

    expect(article.errors[:original_author]).to_not include('não pode ser vazio')
  end

  it 'is invalid with original_author' do
    article = Articles::Article.new(original_author: nil)

    article.valid?

    expect(article.errors[:original_author]).to include('não pode ser vazio')
  end

  it 'is valid with a message smaller than 150 characters' do
    message = Message.new(text: 'Message Text')
    article = Articles::Article.new(messages: [message])

    article.valid?

    expect(article.errors[:base])
      .to_not include('O comprimento máximo de cada mensagem dever ser de até 150 caracteres')
  end

  it 'is invalid with a message greater than 150 characters' do
    message = Message.new(text: 'A' * 152)
    article = Articles::Article.new(messages: [message])

    article.valid?

    expect(article.errors[:base])
      .to include('O comprimento máximo de cada mensagem dever ser de até 150 caracteres')
  end
end
