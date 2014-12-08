require 'rails_helper'

feature "Admin site user visit one message delivery view page" do
  scenario "successfully" do
    user = create(:user, :confirmed, :admin)
    create(:message)
    message_delivery = create(:message_delivery)
    sign_in(user.email, user.password)
    visit admin_message_delivery_path(message_delivery)
    expect(page).to have_content(I18n.t('activerecord.attributes.message_deliveries/message_delivery.profile_name'))
    expect(page).to have_content(I18n.t('activerecord.attributes.message_deliveries/message_delivery.delivery_date'))
    expect(page).to have_content(I18n.t('activerecord.attributes.message_deliveries/message_delivery.message_for_test'))
    expect(page).to have_content(message_delivery.profile_name)
    expect(page).to have_content(message_delivery.delivery_date)
    expect(page).to have_content(message_delivery.message_for_test)
  end
end
