class MessageDeliveriesController < ApplicationController
  def create
    flash[:notice] = "Mensagens Enviadas!"
    messages.each {|msg| send_message(msg)}
    redirect_to root_path
  end

  protected

  def messages
    Message.all
  end

  def send_message(message)
    sender = MessageSender.new(message)
    sender.send_messages
  end
end
