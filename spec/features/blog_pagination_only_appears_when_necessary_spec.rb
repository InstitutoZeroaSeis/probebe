require 'rails_helper'

feature "Blog pagination only appears when necessary" do
  scenario "With just one page" do
    visit root_path

    expect(page).to_not have_selector('a', text: strip_tags(I18n.t('views.blog.older_html')))
    expect(page).to_not have_selector('a', text: strip_tags(I18n.t('views.blog.newer_html')))
  end

  scenario "With three pages and on page two" do
    create_list(:journalistic_article, PostsController::POSTS_PER_PAGE * 3)
    visit root_path(page: 2)

    expect(page).to have_selector('a', text: strip_tags(I18n.t('views.blog.older_html')))
    expect(page).to have_selector('a', text: strip_tags(I18n.t('views.blog.newer_html')))
  end
end
