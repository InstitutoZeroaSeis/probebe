require 'rails_helper'

feature 'Admin site user visit one article view page' do
  before { login_as create(:user, :admin) }

  scenario 'successfully' do
    article = create(:article)

    visit admin_article_path(article)

    expect(current_path).to eq(admin_article_path(article))

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
