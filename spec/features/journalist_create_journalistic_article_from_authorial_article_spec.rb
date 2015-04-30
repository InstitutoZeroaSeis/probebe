require 'rails_helper'

feature 'Journalist create journalistic article from authorial article' do
  before { login_as create(:user, :journalist) }

  scenario 'successfully' do
    article_title = 'Test title see if index showing title'
    authorial_article = create(
      :authorial_article, baby_target_type: 'pregnancy', gender: 'both'
    )
    visit admin_authorial_articles_path

    click_on I18n.t('carnival.create_journalistic_article')
    fill_in 'articles_journalistic_article_title', with: article_title
    fill_in 'articles_journalistic_article_text', with: 'New Text'
    click_on I18n.t('create')

    expect(current_path).to eq(admin_journalistic_articles_path)
    expect(page).to have_content('New Text')
    expect(page).to have_content(authorial_article.category.name)
  end

  scenario 'and the page presents a field with the parent article id' do
    authorial_article = create(
      :authorial_article, baby_target_type: 'pregnancy', gender: 'both'
    )

    visit admin_authorial_articles_path
    click_on I18n.t('carnival.create_journalistic_article')

    expect(current_path).to eq(new_admin_journalistic_article_path)
    expect(page).to have_field(
      'articles_journalistic_article_category_id',
      with: authorial_article.category_id
    )
  end
end
