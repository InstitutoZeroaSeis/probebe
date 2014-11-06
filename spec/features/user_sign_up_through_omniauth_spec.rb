require 'rails_helper'

feature "OAuth2 authentication" do
  before { OmniAuth.config.test_mode = true }

  context "With valid credentials" do
    before { OmniAuth.config.add_mock :google_oauth2, OmniAuthStub::Google::BasicInfo }
    scenario "User sign up through omniauth" do
      sign_in_through_oauth
      expect(current_path).to eq(edit_profile_path)
    end
  end

  context "With invalid credentials" do
    before { OmniAuth.config.add_mock :google_oauth2, OmniAuthStub::Google::WithoutEmail }
    scenario "User gets redirected back to login page", js: true do
      sign_in_through_oauth
      expect(page).to have_text(I18n.t('controller.messages.could_not_sign_up_with_omniauth'))
      expect(current_path).to eq(new_user_session_path)
    end
  end

end
