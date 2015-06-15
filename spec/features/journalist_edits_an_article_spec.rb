require 'rails_helper'

feature 'Journalist edits an authorial article' do
  before { login_as create(:user, :journalist) }

  scenario 'successfully' do
    article = create(:article)

    article_title = 'New title'
    visit edit_admin_article_path(article)
    fill_in 'articles_article_title', with: article_title
    click_on I18n.t('update')
    visit admin_articles_path

    expect(page).to have_content(article_title)
  end
end
