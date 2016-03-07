class MessageDeliveryFinderWorker
  include Sidekiq::Worker

  def perform(managerMessage_id)
    MessageDeliveries::MessageDeliveryFinder.find_and_deliver_messages(managerMessage_id)
  end

end
