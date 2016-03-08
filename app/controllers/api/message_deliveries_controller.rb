class Api::MessageDeliveriesController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    children = Child.completed_profile.select { |child| child.valid_age_in_weeks? }
    managerMessage = MessageDeliveries::ManagerMessageDeliveries.create(messages_created_start: Time.now, sum_messages_created: children.size)

    children.map do |child|
      MessageSenderWorker.perform_async(Date.today, child.id)
    end
    managerMessage.update(creator_jobs_end: Time.now)
    head :ok
  end

end
