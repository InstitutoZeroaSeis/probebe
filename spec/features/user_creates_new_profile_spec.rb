require 'rails_helper'

feature "User creates new profile" do
  scenario "successfully", js: true do
    user = create(:user, :confirmed)
    sign_in(user.email, user.password)
    fill_in "profile_first_name", with: "Name"
    fill_in "profile_last_name", with: "Surname"
    fill_in "profile_birth_date", with: 20.years.ago.strftime("%d/%m/%Y")
    find("select[name='profile[gender]']") { select 'Feminino' }
    find('body').click

    click_on 'Incluir Filho'
    within ".child_fields" do
      find("input[name$='[birth_date]']").set(1.years.ago.strftime("%d/%m/%Y"))
    end

    within ".cell_phone_fields" do |child_fields|
      find("input[name$='[number]']").set("12345678")
    end

    click_button 'Criar Perfil'

    expect(page).to have_content("Informações Pessoais")
    expect(current_path).to eq(profile_path)
  end
end
