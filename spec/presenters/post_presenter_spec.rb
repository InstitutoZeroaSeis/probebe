require 'spec_helper'

RSpec.describe PostPresenter do
  it 'presents the summary if it has one' do
    summary = 'Post Summary'
    post = double(summary: summary)

    post_presenter = PostPresenter.new(post)

    expect(post_presenter.post_summary).to eq(summary)
  end

  it 'presents the truncated text if it has no summary' do
    text = 'A' * (PostPresenter::TEXT_MAXIMUM_LENGTH + 1)
    post = double(summary: '', text: text)

    post_presenter = PostPresenter.new(post)

    expect(post_presenter.post_summary.length).to be <= PostPresenter::TEXT_MAXIMUM_LENGTH
  end

  it 'it should return author name' do
    author = double(name: 'author')
    post = double(original_author: author)

    post_presenter = PostPresenter.new(post)

    expect(post_presenter.author_name).to eq(author.name)
  end

  it 'it should return author photo url' do
    author = double(photo_url: 'avatar/url')
    post = double(original_author: author)

    post_presenter = PostPresenter.new(post)

    expect(post_presenter.author_photo_url).to eq(author.photo_url)
  end
end
