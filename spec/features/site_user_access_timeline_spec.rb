require 'rails_helper'

feature "Site user access timeline" do
  before { OmniAuth.config.test_mode = true }
  before { OmniAuth.config.add_mock :google_oauth2, OmniAuthStub::Google::BasicInfo }
  before { @user = create(:user, :site_user, email: OmniAuthStub::Google::BasicInfo[:info][:email]) }
  before { @profile = create(:profile, user: @user, children: create_list(:child, 1)) }
  scenario "successfully" do
    sign_in_through_oauth
    visit timeline_path(@profile.children.first.id)
    expect(page).to have_content(I18n.t('general.commom_words.timeline'))
  end
end
