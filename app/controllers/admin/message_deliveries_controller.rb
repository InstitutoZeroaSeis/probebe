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
    date = permitted_params[:message_delivery][:delivery_date]
    system_date = SystemDate.new(date)
    article_finder = ArticlesFinder.new(articles, child, system_date)
    message_finder = MessageFinder.new(article_finder)
    sender = MessageSender.new(message_finder)
    sender.send_messages(date)
  end

  def permitted_params
    params.permit(message_delivery:[:delivery_date])
  end
end
