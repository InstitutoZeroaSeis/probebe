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

  def send_message(child)
    date = permitted_params[:message_deliveries_message_delivery][:delivery_date]
    testing_mode = permitted_params[:message_deliveries_message_delivery][:message_for_test]

    system_date = MessageDeliveries::SystemDate.new(date)
    sender = MessageDeliveries::MessageSender.new(child, system_date)

    sender.send_message(testing_mode)
  end

  def permitted_params
    params.permit(message_deliveries_message_delivery: [:delivery_date, :message_for_test])
  end
end
