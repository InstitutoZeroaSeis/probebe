require 'rails_helper'

feature "Admin site user access admin namespace" do
  before { OmniAuth.config.test_mode = true }
  before { OmniAuth.config.add_mock :google_oauth2, OmniAuthStub::Google::BasicInfo }
  before { @user = create(:user, :admin, email: OmniAuthStub::Google::BasicInfo[:info][:email]) }
  scenario "and is not redirected from the admin root path" do
    sign_in_through_oauth
    visit carnival_root_path
    expect(current_path).to eq(carnival_root_path)
  end
end
