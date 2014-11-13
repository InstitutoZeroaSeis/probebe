require 'rails_helper'

feature "User paginates blog pages" do
  scenario "successfully" do
    per_page = PostsController::POSTS_PER_PAGE
    current_page = 2
    create_list(:journalistic_article, per_page * 3)
    posts = Articles::JournalisticArticle.order(created_at: :desc)
    expected_titles = posts.offset(current_page * per_page).limit(per_page).map(&:title)
    non_expected_titles = Articles::JournalisticArticle.all.map(&:title) - expected_titles

    visit root_path(page: current_page)
    click_on strip_tags(I18n.t('views.blog.older_html'))

    all('h2.post_title').each do |post_element|
      expect(expected_titles).to include(post_element.text)
    end

    all('h2.post_title').each do |post_element|
      expect(non_expected_titles).to_not include(post_element.text)
    end

  end
end
