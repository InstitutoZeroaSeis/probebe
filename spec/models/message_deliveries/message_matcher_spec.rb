require 'rails_helper'

RSpec.describe MessageDeliveries::MessageMatcher, type: :model do
  before(:each) { @system_date = MessageDeliveries::SystemDate.new }
  let(:system_date) { MessageDeliveries::SystemDate.new }

  it 'filters only messages that apply to the children profile' do
    first_message = create(:message_for_delivery, :male, maximum_valid_week: 22, baby_target_type: 'born')
    last_message = create(:message_for_delivery, :both, minimum_valid_week: 10, baby_target_type: 'born')

    child = create(:child, birth_date: 5.months.ago)

    matcher = MessageDeliveries::MessageMatcher.new(Message.all, child, system_date)
    matched_message = matcher.match_message_for_child

    expect(matched_message.id).to eq(first_message.id)
  end

  it 'filters out non applicable messages' do
    create(:message_for_delivery, :male)
    message_to_match = create(:message_for_delivery, :female, maximum_valid_week: 22, baby_target_type: 'born')

    child = create(:child, :female, birth_date: 5.months.ago)

    matcher = MessageDeliveries::MessageMatcher.new(Message.all, child, system_date)
    matched_message = matcher.match_message_for_child

    expect(matched_message.id).to eq(message_to_match.id)
  end

  it 'filters out already sent messages' do
    child = create(:child, birth_date: 5.months.ago)
    sent_message = create(:message_for_delivery, :both, baby_target_type: 'born', minimum_valid_week: 10)
    create(:message_delivery, message: sent_message, child: child)
    not_sent_message = create(:message_for_delivery, :both, baby_target_type: 'born', minimum_valid_week: 12)

    matcher = MessageDeliveries::MessageMatcher.new(Message.all, child, system_date)
    matched_message = matcher.match_message_for_child

    expect(matched_message.id).to eq(not_sent_message.id)
  end

  it 'sends the older message in case it can\'t choose the appropriate one' do
    child = create(:child, birth_date: 5.months.ago)
    older_message = create(:message_for_delivery, :both, baby_target_type: 'born', minimum_valid_week: 10)
    create(:message_for_delivery, :both, baby_target_type: 'born', minimum_valid_week: 10)

    matcher = MessageDeliveries::MessageMatcher.new(Message.all, child, system_date)
    matched_message = matcher.match_message_for_child

    expect(matched_message.id).to eq(older_message.id)
  end

  it 'returns nil if there are no matching messages' do
    child = create(:child, :female)
    create(:message_for_delivery, :male)

    matcher = MessageDeliveries::MessageMatcher.new(Message.all, child, system_date)
    matched_message = matcher.match_message_for_child

    expect(matched_message).to be_nil
  end

  it 'with two matching messages send the one with the nearest "due date"' do
    child = create(:child, :with_profile, birth_date: 1.week.ago)
    create(:message_for_delivery, baby_target_type: 'born', maximum_valid_week: 2)
    message_in_due_date = create(:message_for_delivery, baby_target_type: 'born', maximum_valid_week: 1)

    matcher = MessageDeliveries::MessageMatcher.new(Message.all, child, system_date)
    matched_message = matcher.match_message_for_child

    expect(matched_message.id).to eq(message_in_due_date.id)
  end

  it 'matches the category with less sent messages' do
    less_sent_category, more_sent_category = create_pair(:category, :with_parent)

    child = create(:child, :with_profile, birth_date: 1.week.ago)

    more_sent_category_message = create(:message_for_delivery, baby_target_type: 'born', maximum_valid_week: 2, category: more_sent_category)
    less_sent_category_message = create(:message_for_delivery, baby_target_type: 'born', maximum_valid_week: 2, category: less_sent_category)
    create_pair(:message_delivery, category: more_sent_category, child: child)
    create(:message_delivery, category: more_sent_category, child: child)

    matcher = MessageDeliveries::MessageMatcher.new(Message.all, child, system_date)
    matched_message = matcher.match_message_for_child

    expect(matched_message.id).to_not eq(more_sent_category.id)
  end
end
