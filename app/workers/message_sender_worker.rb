class MessageSenderWorker
  include Sidekiq::Worker

  def perform(date, testing_mode = false)
    system_date = MessageDeliveries::SystemDate.new(date)
    processor = MessageDeliveries::MessageDeliveryCreator.new(system_date, testing_mode: testing_mode)
    processor.create_deliveries_for_all_children
  end

end
