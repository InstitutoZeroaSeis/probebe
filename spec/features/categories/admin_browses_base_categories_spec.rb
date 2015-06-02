require 'rails_helper'

feature 'Admin browses base categories' do
  scenario 'and sees all base categories' do
    login_as create(:user, :admin)
    base_category = create(:category)

    visit admin_categories_path

    expect(page).to have_content(base_category.name)
  end

  scenario 'and sees no child categories' do
    login_as create(:user, :admin)
    child_category = create(:category, :with_parent)

    visit admin_categories_path

    expect(page).to_not have_content(child_category.name)
  end
end
