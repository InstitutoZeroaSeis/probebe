require 'rails_helper'

feature "Admin site user access public site" do
  before { OmniAuth.config.test_mode = true }
  before { OmniAuth.config.add_mock :google_oauth2, OmniAuthStub::Google::BasicInfo }
  before { @user = create(:user, :admin, email: OmniAuthStub::Google::BasicInfo[:info][:email]) }
  scenario "and gets redirected to the admin root" do
    sign_in_through_oauth
    visit profile_path
    expect(current_path).to eq(carnival_root_path)
  end
end
