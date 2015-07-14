require 'rails_helper'

feature "Anonymous user visits posts page" do
  scenario "successfully" do
    posts = create_list(:article, 3)
    visit articles_path
    posts.each do |post|
      expect(page).to have_selector('.post-title', text: post.title)
    end
  end
end
