class MessageDeliveriesController < ApplicationController
  before_filter :deny_admin_site_user_access_on_public_site
  before_filter :check_profile_status

  def create
    flash[:notice] = "Mensagens Enviadas!"
    articles.each {|article| send_message(article)}
    redirect_to root_path
  end

  protected

  def articles
    Articles::AuthorialArticle.all
  end

  def send_message(article)
    finder = ProfileFinder.new(article)
    sender = MessageSender.new(finder)
    sender.send_messages
  end
end
