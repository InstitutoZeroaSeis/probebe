require 'rails_helper'

feature 'Users adds child' do
  scenario 'successfully', :js do
    user = create(:user, :confirmed, :site_user, :with_profile)
    profile = user.profile
    sign_in(user.email, user.password)

    visit edit_profile_path(user.profile)

    click_on 'Já nasceu'

    fill_in 'child_name', with: 'Child Name'
    fill_in 'child_birth_date', with: 1.year.ago.strftime('%d/%m/%Y')

    find('.save-child').click

    expect(page).to have_content('Child Name')

    visit edit_profile_path(user.profile)
    expect(page).to have_content('Child Name')
  end
end
