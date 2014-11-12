require 'rails_helper'

feature "Admin user creates another user" do
  scenario "successfully" do
    user = create(:user, :confirmed, :admin)
    new_user_email = 'new-journalist@probebe.com.br'
    new_user_password = '12345678'

    sign_in(user.email, user.password)
    visit new_admin_user_path
    fill_in 'user[email]', with: new_user_email
    find('option', text: 'Administrador').select_option
    click_on I18n.t('create')

    expect(current_path).to eq(admin_users_path)
    expect(page).to have_content(new_user_email)

    sign_out

    mail_body = ActionMailer::Base.deliveries.last.body.raw_source
    confirmation_link = extract_link_from_text('reset_password_link', mail_body)
    visit confirmation_link

    fill_in 'user[password]', with: new_user_password
    fill_in 'user[password_confirmation]', with: new_user_password
    click_on 'Alterar minha senha'

    sign_in(new_user_email, new_user_password)

    expect(current_path).to eq(carnival_root_path)
  end
end