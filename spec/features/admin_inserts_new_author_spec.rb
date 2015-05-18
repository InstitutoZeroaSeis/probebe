require 'rails_helper'

feature 'Admin inserts new author' do
  scenario 'succesfully' do
    login_as create(:user, :admin)
    visit new_admin_author_path
    author_name = 'Author Name'
    author_bio = 'Author Bio'

    fill_in 'authors_author_name', with: author_name
    fill_in 'authors_author_bio', with: author_bio
    attach_file 'authors_author_photo', Rails.root.join('spec/stubs/author_photo.png')
    click_on I18n.t('create')

    visit admin_authors_path
    click_on I18n.t('carnival.show')
    expect(page).to have_content(author_name)
    expect(page).to have_content(author_bio)
  end

  scenario 'missing information' do
    login_as create(:user, :admin)
    visit new_admin_author_path
    author_bio = 'Author Bio'

    fill_in 'authors_author_bio', with: author_bio
    attach_file 'authors_author_photo', Rails.root.join('spec/stubs/author_photo.png')
    click_on I18n.t('create')

    expect(page).to have_content('Nome não pode ser vazio')
    expect(current_path).to eq(admin_authors_path)
  end
end
