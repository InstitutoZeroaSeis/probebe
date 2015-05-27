class Api::MessageDeliveriesController < ApplicationController
  include HeaderAuthenticationConcern

  protect_from_forgery with: :null_session

  def create
    MessageSenderWorker.perform_async(Date.today)
    head :ok
  end
end
