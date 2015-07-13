require 'rails_helper'

feature 'Site user access timeline' do
  let!(:user) { create(:user) }
  before { login_as user }
  before { Timecop.freeze Date.new(2015, 5, 15) }
  after { Timecop.return }

  context 'with two events' do
    let!(:child) do
      create :child, profile: user.profile,  message_deliveries: [
        create(:message_delivery, delivery_date: 3.days.ago),
        create(:message_delivery, delivery_date: 1.days.ago)
      ]
    end

    before { user.reload }
    scenario 'and sees its child events' do
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

  context 'with one message derived from a published article' do
    let(:article) { create(:article, :published) }
    let(:message) { create(:message, article: article) }
    let(:child) { create(:child, profile: user.profile) }
    let(:message_delivery) { create(:message_delivery, message: message, delivery_date: Date.today, child: child) }

    scenario 'and sees a link for a blog post in the message box' do
      visit timeline_path(message_delivery.child)
      link_content = message_delivery.text
      link_href = raw_article_path(message_delivery.article.id)

      within_timeline(Date.today) do
        expect(page).to have_message_with_link_to_post(link_content, link_href)
      end
    end
  end

  context 'with one message derived from a non published article' do
    let(:article) { create(:article, :unpublished) }
    let(:message) { create(:message, article: article) }
    let(:child) { create(:child, profile: user.profile) }
    let(:message_delivery) { create(:message_delivery, message: message, delivery_date: Date.today, child: child) }

    scenario "and doesn't see a link for a blog post in the message box" do
      visit timeline_path(message_delivery.child)
      link_content = message_delivery.text

      within_timeline(Date.today) do
        expect(page).to not_have_message_with_link_to_post(link_content)
      end
    end
  end
end
