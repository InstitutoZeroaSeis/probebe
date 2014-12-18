class MessageSenderWorker
  include Sidekiq::Worker

  def perform(date, testing_mode = false)
    system_date = MessageDeliveries::SystemDate.new(date)
    processor = MessageDeliveries::MessageProcessor.new(system_date, testing_mode: testing_mode)
    processor.send_messages
  end

end
