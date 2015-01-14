require 'rails_helper'

feature "Journalist create journalistic article from authorial article" do
  scenario "successfully" do
    user = create(:user, :confirmed, :journalist)
    article_title = "Test title see if index showing title"
    @authorial_article = create(:authorial_article, baby_target_type: 'pregnancy', gender: 'both')
    sign_in(user.email, user.password)
    visit admin_authorial_articles_path
    click_on I18n.t('carnival.create_journalistic_article')


    expect(current_path).to eq(new_admin_journalistic_article_path)
    expect(page).to have_field('articles_journalistic_article_category_id', with: @authorial_article.category.id)

    fill_in "articles_journalistic_article_title", with: article_title
    fill_in "articles_journalistic_article_text", with: "Text"

    click_on I18n.t('create')
    expect(current_path).to eq(admin_journalistic_articles_path)
    expect(page).to have_content("Text")
    expect(page).to have_content(@authorial_article.category.name)
  end
end
