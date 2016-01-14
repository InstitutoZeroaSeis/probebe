module Api
  class MessagesController < ApplicationController
    include HeaderAuthenticationConcern

    def show
      message = Child.find(params[:id]).message_deliveries
      render json: message
    end

    def default_serializer_options
      { root: false }
    end
  end
end
