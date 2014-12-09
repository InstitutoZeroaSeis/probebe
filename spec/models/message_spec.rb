require 'rails_helper'

RSpec.describe Message, :type => :model do
  context "Message created from journalistic article" do
    before { @article = create(:journalistic_article,:male,
                                maximum_valid_week: 10,
                                baby_target_type: 'pregnancy',
                                messages: create_list(:message, 1)) }

      subject {@messageable_type = @article.messages.first.messageable_type}
      it { is_expected.to eq("Articles::JournalisticArticle") }
    end
  end
