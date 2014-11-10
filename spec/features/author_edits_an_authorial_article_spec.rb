require 'rails_helper'

feature "Author edits an authorial article" do
  scenario "successfully" do
    user = create(:user, :confirmed, :author)
    authorial_article = create(:authorial_article, user: user)
    sign_in(user.email, user.password)

    article_title = "New title"
    visit edit_admin_authorial_article_path(authorial_article)
    fill_in "articles_authorial_article_title", with: article_title

    click_on I18n.t('update')

    expect(current_path).to eq(carnival_root_path)
    expect(page).to have_content(article_title)
  end
end
