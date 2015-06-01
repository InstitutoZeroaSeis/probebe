require 'rails_helper'

feature 'Admin user creates another user' do
  before { login_as create(:user, :admin) }

  scenario 'and the user is shown in the user list' do
    new_user_email = 'new-journalist@probebe.com.br'

    visit new_admin_admin_site_user_path
    fill_in 'user[email]', with: new_user_email
    find('option', text: 'Administrador').select_option
    fill_in 'user_profile_attributes_name', with: 'user name'
    click_on I18n.t('create')
    visit admin_admin_site_users_path

    expect(page).to have_content(new_user_email)
  end

  scenario 'and an email is sent to the new user' do
    new_user_email = 'new-journalist@probebe.com.br'

    visit new_admin_admin_site_user_path
    fill_in 'user[email]', with: new_user_email
    find('option', text: 'Administrador').select_option
    fill_in 'user_profile_attributes_name', with: 'user name'
    click_on I18n.t('create')

    password_reset_email = ActionMailer::Base.deliveries.last
    expect(password_reset_email.to).to include(new_user_email)
  end
end
