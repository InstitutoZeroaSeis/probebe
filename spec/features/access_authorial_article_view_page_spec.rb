require 'rails_helper'

feature 'Admin site user visit one authorial article view page' do
  before { login_as create(:user, :admin) }

  scenario 'successfully' do
    article = create(:authorial_article)

    visit admin_authorial_article_path(article)

    expect(current_path).to eq(admin_authorial_article_path(article))

    expect(page).to have_content(article.id)
    expect(page).to have_content(
      I18n.t('activerecord.attributes.articles/article.id')
    )

    expect(page).to have_content(
      I18n.t('activerecord.attributes.articles/article.title')
    )
    expect(page).to have_content(article.title)
  end
end
