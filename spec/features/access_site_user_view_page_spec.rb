require 'rails_helper'

feature "Admin visit one site user view page" do
  scenario "successfully" do
    user = create(:user, :admin)
    sign_in(user.email, user.password)
    visit admin_site_user_path(user)
    expect(current_path).to eq(admin_site_user_path(user))
    expect(page).to have_content(I18n.t('activerecord.attributes.user.id'))
    expect(page).to have_content(I18n.t('activerecord.attributes.user.email'))
    expect(page).to have_content(user.id)
    expect(page).to have_content(user.email)
  end
end
