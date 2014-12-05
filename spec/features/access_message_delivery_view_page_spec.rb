require 'rails_helper'

feature "Admin site user visit one message delivery view page" do
  scenario "successfully" do
    user = create(:user, :confirmed, :admin)
    message = create(:message)
    message_delviery = create(:message_delivery)
    sign_in(user.email, user.password)
    visit admin_message_delivery_path(message)
    expect(current_path).to eq(admin_message_delivery_path(message))
    expect(page).to have_content(I18n.t('activerecord.attributes.message_delivery.profile_name'))
    expect(page).to have_content(I18n.t('activerecord.attributes.message_delivery.delivery_date'))
    expect(page).to have_content(I18n.t('activerecord.attributes.message_delivery.message_for_test'))
    expect(page).to have_content(message_delviery.profile_name)
    expect(page).to have_content(message_delviery.delivery_date)
    expect(page).to have_content(message_delviery.message_for_test)
  end
end
