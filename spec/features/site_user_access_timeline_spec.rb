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

  scenario "successfully" do
    visit timeline_path(child)

    within "li.timeline-steps.step-01 .day-data" do
      expect(page).to have_css('.day', text: "")
    end
    within "li.timeline-steps.step-02 .day-data" do
      expect(page).to have_css('.day', text: Date.yesterday.strftime("%d").rjust(2, '0'))
    end
    within "li.timeline-steps.step-03 .day-data" do
      expect(page).to have_css('.day', text: "")
    end
    within "li.timeline-steps.step-04 .day-data" do
      expect(page).to have_css('.day', text: 3.days.ago.strftime("%d").rjust(2, '0'))
    end
  end

end
