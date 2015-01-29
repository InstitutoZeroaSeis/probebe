require 'rails_helper'

feature "Admin site user visit one category view page" do
  scenario "successfully" do
    user = create(:user, :confirmed, :admin)
    category = create(:category)
    sign_in(user.email, user.password)
    visit admin_category_path(category)
    expect(current_path).to eq(admin_category_path(category))
    expect(page).to have_content(I18n.t('activerecord.attributes.category.id'))
    expect(page).to have_content(I18n.t('activerecord.attributes.category.name'))
    expect(page).to have_content(I18n.t('activerecord.attributes.category.parent_category'))
    expect(page).to have_content(category.id)
    expect(page).to have_content(category.name)
    expect(page).to have_content(category.parent_category)
  end
end
