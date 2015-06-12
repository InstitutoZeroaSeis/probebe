shared_examples 'a article' do |factory_name|
  it 'updates the messages with the correct attributes' do
    article = build(factory_name, :with_messages)

    article.save

    article.messages.each do |message|
      expect(article.gender).to eq(message.gender)
      expect(article.teenage_pregnancy).to eq(message.teenage_pregnancy)
      expect(article.baby_target_type).to eq(message.baby_target_type)
      expect(article.minimum_valid_week).to eq(message.minimum_valid_week)
      expect(article.maximum_valid_week).to eq(message.maximum_valid_week)
      expect(article.category).to eq(message.category)
    end
  end
end
