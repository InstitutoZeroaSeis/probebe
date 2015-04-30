require 'rails_helper'

feature 'Author try to create journalistic article from authorial article ' do
  before { login_as create(:user, :author) }

  scenario 'expect to redirect to authorial article index' do
    create(:authorial_article)

    visit admin_authorial_articles_path

    click_on I18n.t('carnival.create_journalistic_article')
    expect(current_path).to eq(carnival_root_path)
  end
end
