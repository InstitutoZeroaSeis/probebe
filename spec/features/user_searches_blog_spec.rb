require 'rails_helper'

feature 'User searches blog' do
  scenario 'succesfully' do
    login_as create(:user)
    to_not_be_found = create(:post, title: 'Not included in search')
    first_to_be_found = create(:post, title: 'Security 1')
    second_to_be_found = create(:post, title: 'Security 2')

    visit root_path
    fill_in 'search', with: 'security'
    find('.search-submit').click

    expect(page).to have_selector(
      '.post-title', text: first_to_be_found.title
    )
    expect(page).to have_selector(
      '.post-title', text: second_to_be_found.title
    )
    expect(page).to have_no_selector(
      '.post-title', text: to_not_be_found.title
    )
  end
end
