require 'rails_helper'

RSpec.describe Articles::MessageUpdater, :type => :model do
  context "given an article and a message" do
    let(:article) { create :journalistic_article }
    let(:message) { create :message }

    it "is expected to update message attributes from the article" do
      gender = 'male'
      teenage_pregnancy = false
      baby_target_type = 'born'
      minimum_valid_week = 20
      maximum_valid_week = 30
      category = build_stubbed(:category)

      article = double('article')
      allow(article).to receive(:gender).and_return(gender)
      allow(article).to receive(:teenage_pregnancy).and_return(teenage_pregnancy)
      allow(article).to receive(:baby_target_type).and_return(baby_target_type)
      allow(article).to receive(:minimum_valid_week).and_return(minimum_valid_week)
      allow(article).to receive(:maximum_valid_week).and_return(maximum_valid_week)
      allow(article).to receive(:category).and_return(category)

      message = double('message')
      expect(message).to receive(:gender=).with(gender)
      expect(message).to receive(:teenage_pregnancy=).with(teenage_pregnancy)
      expect(message).to receive(:baby_target_type=).with(baby_target_type)
      expect(message).to receive(:minimum_valid_week=).with(minimum_valid_week)
      expect(message).to receive(:maximum_valid_week=).with(maximum_valid_week)
      expect(message).to receive(:category=).with(category)
      allow(message).to receive(:save!)

      Articles::MessageUpdater.update_from_article(message, article)
    end

  end
end
