require 'rails_helper'

feature "Site user access admin namespace" do
  before { OmniAuth.config.test_mode = true }
  before { OmniAuth.config.add_mock :google_oauth2, OmniAuthStub::Google::BasicInfo }
  before { @user = create(:user, :site_user, email: OmniAuthStub::Google::BasicInfo[:info][:email]) }
  before { create(:profile, user: @user) }
  scenario "and gets redirected back to root_path" do
    sign_in_through_oauth
    visit carnival_root_path
    expect(current_path).to eq(root_path)
  end
end
