class MessageSenderWorker
  include Sidekiq::Worker

  def perform(date, testing_mode = false)
    system_date = MessageDeliveries::SystemDate.new(date)
    message_delivery_creator =
      MessageDeliveries::MessageDeliveryCreator.new(system_date, testing_mode: testing_mode)
    message_delivery_creator.create_deliveries_for_all_children
    MessageDeliveryFinderWorker.perform_async
  end

end
