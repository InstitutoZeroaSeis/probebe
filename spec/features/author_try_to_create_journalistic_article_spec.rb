require 'rails_helper'

feature "Author try to create journalistic article from authorial article " do
  scenario "expect to redirect to authorial article index" do
    user = create(:user, :author)
    create(:authorial_article)
    sign_in(user.email, user.password)
    visit admin_authorial_articles_path

    click_on I18n.t('carnival.create_journalistic_article')
    expect(current_path).to eq(carnival_root_path)
  end
end
