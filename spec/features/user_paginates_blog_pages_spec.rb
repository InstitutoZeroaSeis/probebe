require 'rails_helper'

feature "User paginates blog pages" do
  scenario "successfully" do
    per_page = PostsController::POSTS_PER_PAGE
    current_page = 2
    posts = create_list(:journalistic_article, per_page * 3, :random_created_at)
    post_titles = posts.sort_by(&:created_at).reverse.map(&:title)
    expected_titles = post_titles[((current_page - 1) * per_page), current_page * per_page]
    non_expected_titles = post_titles - expected_titles

    visit root_path
    click_on strip_tags(I18n.t('views.blog.older_html'))

    all('h2.post_title').each do |post_element|
      expect(expected_titles).to include(post_element.text)
    end

    all('h2.post_title').each do |post_element|
      expect(non_expected_titles).to_not include(post_element.text)
    end

  end
end
