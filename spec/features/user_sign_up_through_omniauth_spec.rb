require 'rails_helper'

feature 'OAuth2 authentication' do
  before { OmniAuth.config.test_mode = true }

  scenario 'user gets redirected to home if has valid credentials', :js do
    OmniAuth.config.add_mock(
      :google_oauth2, OmniAuthStub::Google::BasicInfo
    )

    visit root_path
    click_on I18n.t('views.application.sign_in')
    within('.modal-signin') { find('.footer-sign-up-google-plus').click }

    expect(current_path).to eq(edit_profile_path)
    expect(page).to have_no_content(I18n.t('views.application.sign_in'))
  end

  scenario 'user is redirected to login page if has invalid credentials', :js do
    OmniAuth.config.add_mock(
      :google_oauth2, OmniAuthStub::Google::WithoutEmail
    )

    visit root_path
    click_on I18n.t('views.application.sign_in')
    within('.modal-signin') { find('.footer-sign-up-google-plus').click }

    expect(page).to have_text(
      I18n.t('controller.messages.could_not_sign_up_with_omniauth')
    )
    expect(current_path).to eq(new_user_session_path)
  end
end
