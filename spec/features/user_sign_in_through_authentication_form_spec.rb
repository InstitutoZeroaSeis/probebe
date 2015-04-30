require 'rails_helper'

feature 'user sign in through authentication form' do
  scenario 'successfully', :js, :skip_auth do
    user = create(:user)

    visit root_path
    click_on I18n.t('views.application.sign_in')
    within '.sign-in' do
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
    end
    click_on 'Entrar'

    expect(current_path).to eq(root_path)
    expect(page).to have_content(user.profile_name)
  end
end
