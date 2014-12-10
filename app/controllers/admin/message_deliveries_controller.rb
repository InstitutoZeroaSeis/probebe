class Admin::MessageDeliveriesController < Admin::AdminController
  defaults resource_class: MessageDeliveries::MessageDelivery
  skip_before_filter :deny_site_user_access_on_admin

  def create
    date = permitted_params[:delivery_date]
    testing_mode = permitted_params[:message_for_test]

    system_date = MessageDeliveries::SystemDate.new(date)
    sender = MessageDeliveries::MessageSender.new(system_date)

    sender.send_messages(testing_mode)

    flash[:notice] = "Mensagens Enviadas!"
    redirect_to admin_message_deliveries_path
  end

  protected

  def permitted_params
    params.require(:message_deliveries_message_delivery).permit(:delivery_date, :message_for_test)
  end
end
