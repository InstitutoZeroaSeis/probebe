require 'rails_helper'

feature 'Admin site user visit one tag view page' do
  before { login_as create(:user, :admin) }

  scenario 'successfully' do
    tag = create(:tag)

    visit admin_tag_path(tag)

    expect(current_path).to eq(admin_tag_path(tag))
    expect(page).to have_content(I18n.t('activerecord.attributes.tag.id'))
    expect(page).to have_content(I18n.t('activerecord.attributes.tag.name'))
    expect(page).to have_content(tag.id)
    expect(page).to have_content(tag.name)
  end
end
