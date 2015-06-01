require 'rails_helper'

feature 'Admin edits author' do
  scenario 'succesfully' do
    login_as create(:user, :admin)
    author = create(:author)
    visit edit_admin_author_path(author)
    updated_author_name = 'Updated Author Name'

    fill_in 'authors_author_name', with: updated_author_name
    click_on I18n.t('update')

    visit admin_authors_path
    click_on I18n.t('carnival.show')
    expect(page).to have_content(updated_author_name)
  end
end
