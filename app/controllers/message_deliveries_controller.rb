class MessageDeliveriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :deny_admin_site_user_access_on_public_site
  before_filter :check_profile_status

  def create
    flash[:notice] = "Mensagens Enviadas!"
    children.each {|child| send_message(child)}
    redirect_to root_path
  end

  protected

  def children
    Child.all
  end

  def articles
    Articles::JournalisticArticle.all
  end

  def send_message(child)
    article_finder = ArticlesFinder.new(articles,child)
    message_finder = MessageFinder.new(article_finder)
    sender = MessageSender.new(message_finder)
    sender.send_messages
  end
end
