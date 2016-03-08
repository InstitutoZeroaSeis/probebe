class Api::MessageDeliveriesController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    managerMessage = MessageDeliveries::ManagerMessageDeliveries.create(messages_created_start: Time.now)
    Child.completed_profile.map do |child|
      MessageSenderWorker.perform_async(Date.today, child.id)
    end
    managerMessage.update(creator_jobs_end: Time.now)
    head :ok
  end

end
