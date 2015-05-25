class Api::MessageDeliveriesController < ApplicationController
  include HeaderAuthenticationConcern

  def create
    MessageSenderWorker.perform_async(Date.today)
    head :ok
  end
end
