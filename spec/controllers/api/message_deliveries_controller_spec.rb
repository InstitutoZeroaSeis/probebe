require 'rails_helper'

RSpec.describe Api::MessageDeliveriesController, :type => :controller do
  describe "POST create" do
    it "is expected to call the MessageSenderWorker with the current date" do
      expect(MessageSenderWorker).to receive(:perform_async).with(Date.today)
      post :create
    end
  end
end
