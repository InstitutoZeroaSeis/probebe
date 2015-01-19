class MessageDeliveryFinderWorker
  include Sidekiq::Worker

  def perform
    MessageDeliveries::MessageDeliveryFinder.find_and_deliver_messages
  end

end
