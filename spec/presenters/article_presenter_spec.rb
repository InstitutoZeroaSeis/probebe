require 'spec_helper'

RSpec.describe ArticlePresenter do
  it 'presents the summary if it has one' do
    summary = 'Post Summary'
    post = double(intro_text: summary)

    post_presenter = ArticlePresenter.new(post)

    expect(post_presenter.post_summary).to eq(summary)
  end

  it 'presents the truncated text if it has no summary' do
    text = 'A' * (ArticlePresenter::TEXT_MAXIMUM_LENGTH + 1)
    post = double(intro_text: '', text: text)

    post_presenter = ArticlePresenter.new(post)

    expect(post_presenter.post_summary.length).to be <= ArticlePresenter::TEXT_MAXIMUM_LENGTH
  end

  it 'it should return author name' do
    author = double(name: 'author')
    post = double(original_author: author)

    post_presenter = ArticlePresenter.new(post)

    expect(post_presenter.author_name).to eq(author.name)
  end

  it 'it should return author photo url' do
    photo =  double(url: 'avatar/url')
    author = double(photo: photo)
    post = double(original_author: author )

    post_presenter = ArticlePresenter.new(post)

    expect(post_presenter.author_photo_url).to eq(author.photo.url)
  end
end
