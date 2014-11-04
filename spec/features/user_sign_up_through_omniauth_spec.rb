require 'rails_helper'

feature "OAuth2 authentication" do
  before { OmniAuth.config.test_mode = true }

  context "With a new user" do
    context "With valid credentials" do
      before { OmniAuth.config.add_mock :google_oauth2, OmniAuthStub::Google::BasicInfo }
      scenario "User sign up through omniauth" do
        visit root_path
        click_on "Logar com Google Oauth2"
        expect(current_path).to eq(edit_profile_path)
      end
    end

    context "With invalid credentials" do
      before { OmniAuth.config.add_mock :google_oauth2, OmniAuthStub::Google::WithoutEmail }
      scenario "User gets redirected back to login page", js: true do
        visit root_path
        click_on "Logar com Google Oauth2"
        expect(page).to have_text(I18n.t('controller.messages.could_not_sign_up_with_omniauth'))
        expect(current_path).to eq(new_user_session_path)
      end
    end
  end

  context "An existing user" do
    before { OmniAuth.config.add_mock :google_oauth2, OmniAuthStub::Google::BasicInfo }
    before { @user = create(:user, email: OmniAuthStub::Google::BasicInfo[:info][:email]) }

    context "With a complete profile" do
      before { create(:profile, user: @user) }
      scenario "Gets redirected to its profile page" do
        visit root_path
        click_on "Logar com Google Oauth2"
        expect(current_path).to eq(root_path)
      end
    end

    context "With an incomplete profile" do
      before { create(:profile, :without_children, :without_cell_phone, user: @user) }
      context "With a incomplete profile" do
        scenario "Gets redirected to its profile edit page" do
          visit root_path
          click_on "Logar com Google Oauth2"
          expect(current_path).to eq(edit_profile_path)
        end
      end
    end
  end

end
