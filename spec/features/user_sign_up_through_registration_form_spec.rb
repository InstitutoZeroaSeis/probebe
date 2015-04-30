require 'rails_helper'

feature 'Standard registration' do
  scenario 'User sign up through registration form', :js, :selenium do
    pending
    visit root_path

    fill_in 'user_profile_attributes_name', with: 'Nome'
    fill_in 'user_email', with: 'someone@example.com'
    fill_in 'user_password', with: '12345678'
    click_on 'Cadastrar-se'

    expect(current_path).to eq(edit_profile_path)
  end
end
