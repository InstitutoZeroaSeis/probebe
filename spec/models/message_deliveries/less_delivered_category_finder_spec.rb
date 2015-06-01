require 'rails_helper'

RSpec.describe MessageDeliveries::LessDeliveredCategoryFinder, type: :model do
  it 'finds the category that was less delivered' do
    less_delivered = create(:category, :with_parent)
    create(:message_delivery, category: less_delivered)
    most_delivered = create(:category, :with_parent)
    create_pair(:message_delivery, category: most_delivered)

    category_matcher = MessageDeliveries::LessDeliveredCategoryFinder.new(
      MessageDeliveries::MessageDelivery.default_scoped
    )
    found_category = category_matcher.find

    expect(found_category.name).to eq(less_delivered.name)
  end

  it 'takes only categories with parent into consideration' do
    category_without_parent = create(:category)
    create(:message_delivery, category: category_without_parent)

    category_matcher = MessageDeliveries::LessDeliveredCategoryFinder.new(
      MessageDeliveries::MessageDelivery.default_scoped
    )
    found_category = category_matcher.find

    expect(found_category).to eq(nil)
  end

  it 'finds categories without deliveries' do
    category = create(:category, :with_parent)

    category_matcher = MessageDeliveries::LessDeliveredCategoryFinder.new(
      MessageDeliveries::MessageDelivery.default_scoped
    )
    found_category = category_matcher.find

    expect(found_category.name).to eq(category.name)
  end
end
