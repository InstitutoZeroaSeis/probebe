class Api::MessageDeliveriesController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    MessageSenderWorker.perform_async(Date.today)
    head :ok
  end
end
