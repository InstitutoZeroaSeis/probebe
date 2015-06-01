require 'rails_helper'

RSpec.describe Api::MessageDeliveriesController, type: :controller do
  describe 'POST create' do
    it 'is expected to call the MessageSenderWorker with the current date' do
      user = create(:user, :site_user)
      authenticate_through_headers(user.email, user.password)
      allow(MessageSenderWorker).to receive(:perform_async)

      post :create

      expect(MessageSenderWorker).to have_received(:perform_async).with(Date.today)
    end
  end
end
