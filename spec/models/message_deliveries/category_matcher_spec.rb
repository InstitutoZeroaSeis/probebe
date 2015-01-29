require 'rails_helper'

RSpec.describe MessageDeliveries::CategoryMatcher, :type => :model do
  before(:each) { @child = create(:child, :with_profile, birth_date: 7.months.from_now)
                  @health_message = create(:message, :with_journalistic_article, :with_health_category)
                  @education_message = create(:message, :with_journalistic_article, :with_education_category)
                  @security_message = create(:message, :with_journalistic_article, :with_security_category)
                  @finance_message = create(:message, :with_journalistic_article, :with_finance_category)
                  @socio_emotional_message = create(:message, :with_journalistic_article, :with_socio_emotional_category)  }

  describe('.find_least_delivered_category') do

    context "child that receive messages from many categories" do
      before { @message_delivery1 = create(:message_delivery, child: @child, message: @health_message) }
      before { @message_delivery2 = create(:message_delivery, child: @child, message: @education_message) }
      before { @message_delivery3 = create(:message_delivery, child: @child, message: @health_message) }
      before { @message_delivery4 = create(:message_delivery, child: @child, message: @finance_message) }
      before { @message_delivery5 = create(:message_delivery, child: @child, message: @socio_emotional_message) }
      subject { MessageDeliveries::CategoryMatcher.new(@child).find_least_delivered_category }
      it { is_expected.to eq('security')  }
    end

    context "child that receive messages from all categories" do
      before { @message_delivery1 = create(:message_delivery, child: @child, message: @health_message) }
      before { @message_delivery2 = create(:message_delivery, child: @child, message: @education_message) }
      before { @message_delivery3 = create(:message_delivery, child: @child, message: @security_message) }
      before { @message_delivery4 = create(:message_delivery, child: @child, message: @finance_message) }
      before { @message_delivery5 = create(:message_delivery, child: @child, message: @socio_emotional_message) }
      subject { MessageDeliveries::CategoryMatcher.new(@child).find_least_delivered_category }
      it { is_expected.to eq('health')  }
    end
  end
end
