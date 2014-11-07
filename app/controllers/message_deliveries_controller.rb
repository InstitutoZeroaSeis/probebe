class MessageDeliveriesController < ApplicationController
  before_filter :check_profile_status

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
    finder = ProfileFinder.new(message)
    sender = MessageSender.new(finder)
    sender.send_messages
  end
end
