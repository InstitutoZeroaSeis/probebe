require 'rails_helper'

RSpec.describe MessageDeliveries::CategoryMatcher, type: :model do
  it 'finds the category that was less delivered' do
    child = create(:child)
    most_delivered = create(:category)
    create_pair(:message_delivery, category: most_delivered, child: child)
    least_delivered = create(:category)
    create(:message_delivery, category: least_delivered, child: child)

    category_matcher = MessageDeliveries::CategoryMatcher.new(child)
    least_delivered_category = category_matcher.find_least_delivered_category

    expect(least_delivered_category).to eq(least_delivered.name)
  end
end
