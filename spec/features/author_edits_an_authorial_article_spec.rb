require 'rails_helper'

feature 'Author edits an authorial article' do
  before { login_as create(:user, :admin) }

  scenario 'successfully' do
    authorial_article = create(:authorial_article)

    article_title = 'New title'
    visit edit_admin_authorial_article_path(authorial_article)
    fill_in 'articles_authorial_article_title', with: article_title
    click_on I18n.t('update')
    visit admin_authorial_articles_path

    expect(page).to have_content(article_title)
  end
end
