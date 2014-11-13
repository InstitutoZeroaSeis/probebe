require 'rails_helper'

feature "User visits a specific post" do
  scenario "successfully" do
    posts = create_list(:journalistic_article, 5)
    first_post = posts.first
    visit root_path
    click_on posts.first.title
    expect(current_path).to eq(post_path(first_post))
    expect(page).to have_content(first_post.title)
  end
end
