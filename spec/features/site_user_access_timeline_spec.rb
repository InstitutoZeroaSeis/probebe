require 'rails_helper'

feature "Site user access timeline" do
  before { OmniAuth.config.test_mode = true }
  before { OmniAuth.config.add_mock :google_oauth2, OmniAuthStub::Google::BasicInfo }
  before { @user = create(:user, :site_user, email: OmniAuthStub::Google::BasicInfo[:info][:email]) }
  before { create(:profile, user: @user) }
  scenario "successfully" do
    sign_in_through_oauth
    visit timeline_path
    expect(page).to have_content(I18n.t('general.commom_words.timeline'))
  end
end
