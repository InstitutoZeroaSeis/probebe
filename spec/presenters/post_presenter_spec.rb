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

  it 'is title to be titleize' do
    title = 'post presenter spec'
    post = double(title: title)

    post_presenter = PostPresenter.new(post)

    expect(post_presenter.titleized_title).to eq('Post Presenter Spec')
  end

  it 'it should return author name' do
    profile = double(name: 'profile')
    post = double(profile: profile)

    post_presenter = PostPresenter.new(post)

    expect(post_presenter.author_name).to eq(profile.name)
  end

  it 'it should return author photo url' do
    profile = double(avatar_url: 'avatar/url')
    post = double(profile: profile)

    post_presenter = PostPresenter.new(post)

    expect(post_presenter.author_photo_url).to eq(profile.avatar_url)
  end
end
