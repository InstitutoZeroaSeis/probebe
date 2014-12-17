require 'rails_helper'

feature "User visits a specific post" do
  scenario "successfully" do
    post = create(:journalistic_article)
    create_list(:journalistic_article, 5, created_at: 2.days.ago)
    visit root_path
    click_on post.title
    expect(current_path).to eq(post_path(post))
    expect(page).to have_content(post.title)
  end
end
