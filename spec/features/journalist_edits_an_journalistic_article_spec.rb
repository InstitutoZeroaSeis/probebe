require 'rails_helper'

feature 'Journalist edit his own journalistic article' do
  let(:user) { create(:user, :journalist) }
  before { sign_in(user.email, user.password) }

  scenario 'successfully' do
    article_title = 'New title'
    journalistic_article = create(:journalistic_article, user: user)
    visit edit_admin_journalistic_article_path(journalistic_article)

    fill_in 'articles_journalistic_article_title', with: article_title
    select user.profile.name,
           from: 'articles_journalistic_article_original_author_id'
    click_on I18n.t('update')
    visit admin_journalistic_articles_path

    expect(current_path).to eq(admin_journalistic_articles_path)
    expect(page).to have_content(article_title)
    expect(page).to have_content(user.profile_name)
  end
end
