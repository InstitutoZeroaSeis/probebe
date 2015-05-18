require 'rails_helper'

RSpec.describe Articles::JournalisticArticle, type: :model do
  context 'with parent authorial article' do
    subject { build_stubbed :journalistic_article, :with_parent_authorial_article }
    it { is_expected.to be_valid }
  end

  context 'without parent article' do
    subject { build_stubbed :journalistic_article, :without_parent_article }
    it { is_expected.to be_invalid }
  end

  context 'without original author' do
    subject { build_stubbed :journalistic_article, :without_original_author }
    it { is_expected.to be_invalid }
  end

  context 'with a message greater than 150 characters' do
    subject { build_stubbed :journalistic_article, messages: create_list(:message, 1, text: 'a' * 151) }
    it { is_expected.to be_invalid }
  end

  context 'with a message smaller than 150 characters' do
    subject { build_stubbed :journalistic_article, messages: create_list(:message, 1, text: 'a' * 149) }
    it { is_expected.to be_valid }
  end

  it 'is ordered from the newest to oldest by default' do
    older_post = create(:journalistic_article)
    newer_post = create(:journalistic_article)

    all_posts = Articles::JournalisticArticle.all

    expect(all_posts.map(&:title))
      .to eq([newer_post.title, older_post.title])
  end

  context 'with messages' do
    subject { build :journalistic_article, :with_message }
    it 'is expected to update the messages with the correct attributes' do
      subject.save
      subject.messages.each do |message|
        expect(subject.gender).to eq(message.gender)
        expect(subject.teenage_pregnancy).to eq(message.teenage_pregnancy)
        expect(subject.baby_target_type).to eq(message.baby_target_type)
        expect(subject.minimum_valid_week).to eq(message.minimum_valid_week)
        expect(subject.maximum_valid_week).to eq(message.maximum_valid_week)
        expect(subject.category).to eq(message.category)
      end
    end
  end
end
