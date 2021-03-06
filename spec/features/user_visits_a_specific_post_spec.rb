require 'rails_helper'

feature 'User visits a specific post' do
  scenario 'successfully' do
    post = create(:post)
    visit articles_path

    click_on post.title

    expect(current_path).to eq(article_path(post))
    expect(page).to have_content(post.title)
  end
end
