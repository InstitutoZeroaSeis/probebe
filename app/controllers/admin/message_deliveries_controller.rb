class Admin::MessageDeliveriesController < Admin::AdminController
  defaults resource_class: MessageDeliveries::MessageDelivery
  skip_before_action :deny_site_user_access_on_admin

  def table_items
    MessageDeliveries::MessageDelivery.includes(:message, :child, :profile)
  end

  def create
    date = permitted_params[:delivery_date]
    testing_mode = permitted_params[:message_for_test]

    MessageSenderWorker.perform_async(date, testing_mode)

    flash[:notice] = "Mensagens Enviadas!"
    redirect_to admin_message_deliveries_path
  end

  protected

  def permitted_params
    if params[:message_deliveries_message_delivery]
      params.require(:message_deliveries_message_delivery).permit(:delivery_date, :message_for_test)
    else
      {}
    end
  end
end
