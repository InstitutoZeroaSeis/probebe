class Admin::MessageDeliveriesController < Admin::AdminController
  defaults resource_class: MessageDeliveries::MessageDelivery
  skip_before_filter :deny_site_user_access_on_admin

  def create
    flash[:notice] = "Mensagens Enviadas!"
    children.each {|child| send_message(child)}
    redirect_to admin_message_deliveries_path
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
    message_for_test = permitted_params[:message_delivery][:message_for_test]
    system_date = MessageDeliveries::SystemDate.new(date)
    articles_matcher = MessageDeliveries::ArticlesMatcher.new(articles, child, system_date)
    message_matcher = MessageDeliveries::MessageMatcher.new(articles_matcher)
    sender = MessageDeliveries::MessageSender.new(message_matcher)
    sender.send_messages(date, message_for_test)
  end

  def permitted_params
    params.permit(message_delivery:[:delivery_date, :message_for_test])
  end
end
