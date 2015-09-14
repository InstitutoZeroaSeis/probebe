require 'rails_helper'

feature 'Publisher edit his own article' do
  before { login_as create(:user, :publisher) }

  scenario 'successfully' do
    article_title = 'New title'
    article = create(:article)
    user = create(:user, :publisher)

    visit edit_admin_article_path(article.id, user: user)
    fill_in 'articles_article_title', with: article_title
    click_on I18n.t('update')
    visit admin_articles_path

    expect(current_path).to eq(admin_articles_path)
    expect(page).to have_content(article_title)
  end
end
