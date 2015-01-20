require 'rails_helper'

feature "Site user access timeline" do
  before { @user = create(:user, :confirmed, :with_profile) }
  before { sign_in(@user.email, @user.password) }

  let(:child) do
    create :child, message_deliveries: [
      create(:message_delivery, delivery_date: 3.days.ago),
      create(:message_delivery, delivery_date: 1.days.ago)
    ]
  end

  scenario "and sees its children events" do
    visit timeline_path(child)

    within_timeline_date(Date.today) do
      expect(page).to have_day_without_text
    end

    within_timeline_date(Date.yesterday) do
      day = day_with_leading_zero Date.yesterday
      expect(page).to have_day_with_text(day)
    end

    within_timeline_date(2.days.ago) do
      expect(page).to have_day_without_text
    end

    within_timeline_date(3.days.ago) do
      day = day_with_leading_zero 3.days.ago
      expect(page).to have_day_with_text(day)
    end
  end

end
