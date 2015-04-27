require 'rails_helper'

feature "Admin site user visit one authorial article view page" do

  scenario "successfully" do
    user = create(:user, :admin)
    article = create(:authorial_article)
    sign_in(user.email, user.password)
    visit admin_authorial_article_path(article)
    expect(current_path).to eq(admin_authorial_article_path(article))
    expect(page).to have_content(I18n.t('activerecord.attributes.articles/article.id'))
    expect(page).to have_content(I18n.t('activerecord.attributes.articles/article.category'))
    expect(page).to have_content(I18n.t('activerecord.attributes.articles/article.title'))
    expect(page).to have_content(I18n.t('activerecord.attributes.articles/article.text'))
    expect(page).to have_content(I18n.t('activerecord.attributes.articles/article.summary'))
    expect(page).to have_content(I18n.t('activerecord.attributes.articles/article.gender'))
    expect(page).to have_content(I18n.t('activerecord.attributes.articles/article.article_references'))
    expect(page).to have_content(I18n.t('activerecord.attributes.articles/article.baby_target_type'))
    expect(page).to have_content(I18n.t('activerecord.attributes.articles/article.journalistic_articles_count'))
    expect(page).to have_content(article.id)
    expect(page).to have_content(article.title)
  end

end
