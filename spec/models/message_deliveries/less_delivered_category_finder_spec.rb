require 'rails_helper'

RSpec.describe MessageDeliveries::LessDeliveredCategoryFinder, type: :model do
  it 'finds the category that was less delivered' do
    less_delivered = create(:category, :with_parent)
    most_delivered = create(:category, :with_parent)
    create_pair(:message_delivery, category: most_delivered)

    category_matcher = MessageDeliveries::LessDeliveredCategoryFinder.new(nil, [most_delivered.id])
    found_category = category_matcher.find

    expect(found_category.name).to eq(less_delivered.name)
  end

  it 'takes only categories with parent into consideration' do
    category_without_parent = create(:category)
    create(:message_delivery, category: category_without_parent)

    category_matcher = MessageDeliveries::LessDeliveredCategoryFinder.new(
      MessageDeliveries::MessageDelivery.default_scoped, [category_without_parent.id]
    )
    found_category = category_matcher.find

    expect(found_category).to eq(nil)
  end

  it 'finds categories without deliveries' do
    category = create(:category, :with_parent)

    category_matcher = MessageDeliveries::LessDeliveredCategoryFinder.new(
      MessageDeliveries::MessageDelivery.default_scoped, nil
    )
    found_category = category_matcher.find

    expect(found_category.name).to eq(category.name)
  end

  it 'considers only deliveries from the given relation' do
    child = create(:child)
    most_delivered_for_all = create(:category, :with_parent)
    create_pair(:message_delivery, category: most_delivered_for_all)
    most_delivered_for_child = create(:category, :with_parent)
    create(:message_delivery, category: most_delivered_for_child, child: child)
    # It doesn't matter for the app, this is just a stub for the test
    # Because Factory Girl creates each message_delivery with its own category
    # and only AFTER that it associates the category param, so this is required
    # to create the ideal db situtation for the test
    categories_relation = Category.where(id: [
      most_delivered_for_all.parent_category_id,
      most_delivered_for_child.parent_category_id
    ])

    category_matcher = MessageDeliveries::LessDeliveredCategoryFinder.new(
      child.message_deliveries, nil, categories_relation
    )
    found_category = category_matcher.find

    expect(found_category.name).to eq(most_delivered_for_all.name)
  end
end
