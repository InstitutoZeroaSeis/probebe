require 'rails_helper'

feature "Admin visit one admin site user view page" do
  scenario "successfully" do
    user = create(:user, :confirmed, :admin)
    sign_in(user.email, user.password)
    visit admin_admin_site_user_path(user)
    expect(current_path).to eq(admin_admin_site_user_path(user))
    expect(page).to have_content(I18n.t('activerecord.attributes.user.id'))
    expect(page).to have_content(I18n.t('activerecord.attributes.user.email'))
    expect(page).to have_content(I18n.t('activerecord.attributes.user.role'))
    expect(page).to have_content(user.id)
    expect(page).to have_content(user.email)
    expect(page).to have_content(user.role)
  end
end
