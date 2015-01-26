require 'rails_helper'

feature "Standard registration" do
  scenario "User sign up through registration form" do
    visit root_path
    click_on I18n.t('views.application.sign_in')
    click_on "Registrar"
    fill_in "Nome", with: "Nome"
    fill_in "Sobrenome", with: "Sobrenome"
    fill_in "Email", with: "someone@example.com"
    fill_in "Senha", with: "12345678"
    fill_in "Confirmação de Senha", with: "12345678"
    click_on "Registrar"

    mail_body = ActionMailer::Base.deliveries.last.body.raw_source
    confirmation_link = extract_link_from_text('confirmation_link', mail_body)
    visit confirmation_link

    sign_in("someone@example.com", "12345678")

    expect(current_path).to eq(root_path)
  end
end
