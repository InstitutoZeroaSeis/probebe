require 'rails_helper'

feature 'user sign in through omniauth' do
  before { OmniAuth.config.test_mode = true }

  scenario 'successfully', :js do
    OmniAuth.config.add_mock :google_oauth2, OmniAuthStub::Google::BasicInfo
    user = create(:user, :with_profile, email: OmniAuthStub::Google::BasicInfo[:info][:email])

    visit root_path
    click_on I18n.t('views.application.sign_in')
    within('.modal-signin') { find('.footer-sign-up-google-plus').click }

    expect(current_path).to eq(root_path)
    expect(page).to have_no_content(I18n.t('views.application.sign_in'))
  end
end
