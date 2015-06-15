require 'rails_helper'

feature 'Journalist inserts many tags through a text input' do
  before { login_as create(:user, :journalist) }

  scenario 'and the tags are associated with the article' do
    article = create(:article)
    tags = 'health, education'
    visit edit_admin_article_path(article)

    fill_in 'articles_article_tag_names', with: tags
    click_on I18n.t('update')
    visit edit_admin_article_path(article)

    expect(
      find('#articles_article_tag_names').value
    ).to eq(tags)
  end
end
