class Admin::MessageDeliveriesController < Admin::AdminController
  defaults resource_class: MessageDelivery
  skip_before_filter :deny_site_user_access_on_admin

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

  def permmited_paramsdef permitted_params
    params.permit(message_delivery: [:delivery_date])
  end
end
