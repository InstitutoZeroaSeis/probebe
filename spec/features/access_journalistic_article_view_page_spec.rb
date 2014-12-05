require 'rails_helper'

feature "Admin site user visit one journalistic article view page" do
  scenario "successfully" do
    user = create(:user, :confirmed, :admin)
    article = create(:journalistic_article)
    sign_in(user.email, user.password)
    visit admin_journalistic_article_path(article)
    expect(current_path).to eq(admin_journalistic_article_path(article))
    expect(page).to have_content(I18n.t('activerecord.attributes.articles/article.category'))
    expect(page).to have_content(I18n.t('activerecord.attributes.articles/article.title'))
    expect(page).to have_content(I18n.t('activerecord.attributes.articles/article.text'))
    expect(page).to have_content(I18n.t('activerecord.attributes.articles/article.summary'))
    expect(page).to have_content(I18n.t('activerecord.attributes.articles/article.gender'))
    expect(page).to have_content(I18n.t('activerecord.attributes.articles/article.baby_target_type'))
    expect(page).to have_content(article.title)

  end
end
