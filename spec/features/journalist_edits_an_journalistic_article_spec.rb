require 'rails_helper'

feature 'Journalist edit his own article' do
  before { login_as create(:user, :journalist) }

  scenario 'successfully' do
    article_title = 'New title'
    article = create(:article)
    user = create(:user, :author)

    visit edit_admin_article_path(article, user: user)
    fill_in 'articles_article_title', with: article_title
    click_on I18n.t('update')
    visit admin_articles_path

    expect(current_path).to eq(admin_articles_path)
    expect(page).to have_content(article_title)
  end
end
