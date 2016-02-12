class RetroactiveMessagesWorker
  include Sidekiq::Worker

  def perform(date, child_id)
    child = Child.find(child_id)
    system_date = MessageDeliveries::SystemDate.new(date)
    message_delivery_creator =
      MessageDeliveries::MessageDeliveryCreator.new(system_date, testing_mode: false)

    while child.age_in_weeks(system_date) >= 0 do
      if system_date.date.monday? || system_date.date.wednesday? || system_date.date.friday?
        message_delivery_creator.system_date = system_date
        message_delivery_creator.create_deliveries_for child
        child.message_deliveries.reload
      end
      system_date = MessageDeliveries::SystemDate.new(system_date.date.prev_day)
    end
  end

end
