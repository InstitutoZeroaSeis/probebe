require 'rails_helper'

feature "Journalist edit your own journalistic article" do
  scenario "successfully" do
    user = create(:user, :confirmed, :journalist)
    journalistic_article = create(:journalistic_article, user: user)
    sign_in(user.email, user.password)

    article_title = "New title"
    visit edit_admin_journalistic_article_path(journalistic_article)
    fill_in "articles_journalistic_article_title", with: article_title

    click_on I18n.t('update')

    expect(current_path).to eq(admin_journalistic_articles_path)
    expect(page).to have_content(article_title)
  end
end
