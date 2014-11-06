require 'rails_helper'

feature "OAuth2 authentication" do
  before { OmniAuth.config.test_mode = true }
  before { OmniAuth.config.add_mock :google_oauth2, OmniAuthStub::Google::BasicInfo }
  before { @user = create(:user, email: OmniAuthStub::Google::BasicInfo[:info][:email]) }

  context "With a complete profile" do
    before { create(:profile, user: @user) }
    scenario "Gets redirected to its profile page" do
      sign_in_through_oauth
      expect(current_path).to eq(root_path)
    end
  end

  context "With an incomplete profile" do
    before { create(:profile, :without_children, :without_cell_phone, user: @user) }
    context "With a incomplete profile" do
      scenario "Gets redirected to its profile edit page" do
        sign_in_through_oauth
        expect(current_path).to eq(edit_profile_path)
      end
    end
  end
end
