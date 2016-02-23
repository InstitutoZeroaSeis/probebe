module Api
  class MessagesController < ApplicationController
    include HeaderAuthenticationConcern

    def show
      message = Child.find(params[:id]).message_deliveries
      render json: message
    end

    def only_new
      last_message = params[:lastMessage]
      if last_message != "0"
        messages = Child.find(params[:id]).message_deliveries.where('id > ? ', last_message.to_i).order('id ASC')
      else
        messages = Child.find(params[:id]).message_deliveries.order('id ASC')
      end
      render json: messages
    end

    def default_serializer_options
      { root: false }
    end
  end
end
