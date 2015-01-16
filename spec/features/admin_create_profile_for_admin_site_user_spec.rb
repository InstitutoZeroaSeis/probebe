require 'rails_helper'

feature "Admin creates a profile" do
  scenario "successfully" do
  admin = create(:user, :confirmed, :admin)
  sign_in(admin.email, admin.password)
  visit admin_admin_site_users_path
  click_on I18n.t('carnival.create_profile')

  expect(current_path).to eq(new_admin_profile_path)

  fill_in "profile_first_name", with: "FirstName"
  fill_in "profile_last_name", with: "Lastname"
  click_on I18n.t('create')

  expect(current_path).to eq(admin_profiles_path)
  end

end
