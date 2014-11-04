require 'rails_helper'

feature "User edits new profile" do
  before { @user = create(:user, :confirmed, :with_profile) }
  before { sign_in(@user.email, @user.password) }

  scenario "successfully", js: true do
    visit edit_profile_path
    fill_in "profile_first_name", with: "New name"

    click_button 'Atualizar Perfil'

    expect(page).to have_content("New name")
    expect(current_path).to eq(profile_path)
  end

  scenario "with invalid data" do
    visit edit_profile_path
    fill_in "profile_first_name", with: ""
    click_button 'Atualizar Perfil'

    expect(page).to have_content("Por favor corrija os problemas abaixo")
  end
end
