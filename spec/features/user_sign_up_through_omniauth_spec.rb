require 'rails_helper'

feature 'OAuth2 authentication' do
  before { OmniAuth.config.test_mode = true }

  scenario 'user gets redirected to home if has valid credentials' do
    OmniAuth.config.add_mock :google_oauth2, OmniAuthStub::Google::BasicInfo

    sign_in_through_oauth

    expect(current_path).to eq(root_path)
  end

  scenario 'user gets redirected back to login page if has invalid credentials', js: true do
    OmniAuth.config.add_mock(
      :google_oauth2, OmniAuthStub::Google::WithoutEmail
    )

    sign_in_through_oauth

    expect(page).to have_text(
      I18n.t('controller.messages.could_not_sign_up_with_omniauth')
    )
    expect(current_path).to eq(new_user_session_path)
  end
end
