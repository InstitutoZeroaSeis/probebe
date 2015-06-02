require 'rails_helper'

feature 'Admin browses child categories' do
  scenario 'and sees all child categories', :js do
    login_as create(:user, :admin)
    child_category = create(:category, :with_parent)

    visit admin_categories_path
    find('[data-scope="sub_categories"]').click

    expect(page).to have_content(child_category.name)
  end

  scenario 'and sees no child categories', :js do
    login_as create(:user, :admin)
    base_category = create(:category)

    visit admin_categories_path
    find('[data-scope="sub_categories"]').click

    expect(page).to_not have_content(base_category.name)
  end
end
