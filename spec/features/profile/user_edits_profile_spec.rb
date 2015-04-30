require 'rails_helper'

feature 'User edits new profile' do
  before { login_as create(:user) }

  scenario 'successfully' do
    visit edit_profile_path
    fill_in 'profile_name', with: 'New name'

    click_button 'Atualizar Perfil'

    expect(page).to have_content('New name')
  end

  scenario 'with invalid data' do
    visit edit_profile_path
    fill_in 'profile_name', with: ''
    click_button 'Atualizar Perfil'

    expect(page).to have_content(
      I18n.t('simple_form.error_notification.default_message')
    )
  end
end
