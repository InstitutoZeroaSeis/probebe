require 'rails_helper'

feature "Anonymous user visits posts page" do
  scenario "successfully" do
    posts = create_list(:journalistic_article, 3)
    visit root_path
    expect(current_path).to eq(root_path)
    posts.each do |post|
      expect(page).to have_selector('h2.post_title', text: post.title)
    end
  end
end
