require 'rails_helper'

RSpec.describe Articles::MessageUpdater, type: :model do
  it 'saves the message' do
    attributes = {
      gender: 'male', teenage_pregnancy: false,
      baby_target_type: 'born', category: '',
      minimum_valid_week: 20, maximum_valid_week: 30
    }
    article = OpenStruct.new(attributes)
    message = spy('message')

    Articles::MessageUpdater.update_from_article(message, article)

    expect(message).to have_received(:save!)
  end

  it 'updates message attributes through articles' do
    attributes = {
      gender: 'male', teenage_pregnancy: false,
      baby_target_type: 'born', category: '',
      minimum_valid_week: 20, maximum_valid_week: 30
    }
    article = OpenStruct.new(attributes)
    message = spy('message')

    Articles::MessageUpdater.update_from_article(message, article)

    attributes.each do |key, value|
      expect(message).to have_received("#{key}=").with(value)
    end
  end
end
