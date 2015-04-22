module Api
  class MessagesController < ApplicationController
    before_action :authenticate_user!

    def show
      message = MessageDeliveries::MessageDelivery.find(params[:id])
      render json: message
    end

    def default_serializer_options
      { root: false }
    end
  end
end
