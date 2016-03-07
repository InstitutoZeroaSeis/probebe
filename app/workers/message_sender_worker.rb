class MessageSenderWorker
  include Sidekiq::Worker

  def perform(date, testing_mode = false)
    managerMessage = MessageDeliveries::ManagerMessageDeliveries.create(messages_created_start: Time.now)

    system_date = MessageDeliveries::SystemDate.new(date)
    message_delivery_creator =
      MessageDeliveries::MessageDeliveryCreator.new(system_date, testing_mode: testing_mode)
    message_delivery_creator.create_deliveries_for_all_children

    managerMessage.update(messages_created_end: Time.now, sum_messages_created: MessageDeliveries::MessageDelivery.created_today.size)
    MessageDeliveryFinderWorker.perform_async(managerMessage.id)
  end

end
