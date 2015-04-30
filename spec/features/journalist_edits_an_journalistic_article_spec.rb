require 'rails_helper'

feature 'Journalist edit his own journalistic article' do
  before { login_as create(:user, :journalist) }

  scenario 'successfully' do
    article_title = 'New title'
    journalistic_article = create(:journalistic_article)
    user = create(:user, :author)

    visit edit_admin_journalistic_article_path(journalistic_article, user: user)
    fill_in 'articles_journalistic_article_title', with: article_title
    select user.profile_name,
           from: 'articles_journalistic_article_original_author_id'
    click_on I18n.t('update')
    visit admin_journalistic_articles_path

    expect(current_path).to eq(admin_journalistic_articles_path)
    expect(page).to have_content(article_title)
    expect(page).to have_content(user.profile_name)
  end
end
