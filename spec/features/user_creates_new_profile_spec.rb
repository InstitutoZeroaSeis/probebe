require 'rails_helper'

feature "User creates new profile" do
  before { @user = create(:user, :confirmed) }
  before { sign_in(@user.email, @user.password) }

  scenario "successfully", js: true do
    fill_in "profile_first_name", with: "Name"
    fill_in "profile_last_name", with: "Surname"
    fill_in "profile_birth_date", with: 20.years.ago.strftime("%d/%m/%Y")
    find("select[name='profile[gender]']") { select 'female' }
    find('body').click

    click_on 'Incluir Filho'
    within ".child_fields" do
      find("input[name$='[birth_date]']").set(1.year.ago.strftime("%d/%m/%Y"))
    end

    within ".cell_phone_fields" do |child_fields|
      find("input[name$='[number]']").set("12345678")
    end

    click_button 'Criar Perfil'

    expect(page).to have_content("Informações Pessoais")
    expect(current_path).to eq(profile_path)
  end

  scenario "with invalid data" do
    click_button 'Criar Perfil'

    expect(page).to have_content(I18n.t('simple_form.error_notification.default_message'))
  end
end
