class MessageSenderWorker
  include Sidekiq::Worker

  def perform(date, child_id, testing_mode = false)
    child = Child.find(child_id)

    system_date = MessageDeliveries::SystemDate.new(date)
    message_delivery_creator =
      MessageDeliveries::MessageDeliveryCreator.new(system_date, testing_mode: testing_mode)

    message_delivery = message_delivery_creator.create_delivery_for(child)
    MessageDeliveries::MessageDeliveryFinder.find_and_deliver_messages(message_delivery) if message_delivery.present?
  end

end
