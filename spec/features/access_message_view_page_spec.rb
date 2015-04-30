require 'rails_helper'

feature 'Admin site user visit one message view page' do
  before { login_as create(:user, :admin) }

  scenario 'successfully' do
    message = create(:message)

    visit admin_message_path(message)

    expect(current_path).to eq(admin_message_path(message))
    expect(page).to have_content(I18n.t('activerecord.attributes.message.id'))
    expect(page).to have_content(I18n.t('activerecord.attributes.message.text'))
    expect(page).to have_content(message.id)
    expect(page).to have_content(message.text)
  end
end
