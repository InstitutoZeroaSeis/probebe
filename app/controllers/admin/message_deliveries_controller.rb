class Admin::MessageDeliveriesController < Admin::AdminController
  defaults resource_class: MessageDeliveries::MessageDelivery
  skip_before_action :deny_site_user_access_on_admin

  def table_items
    MessageDeliveries::MessageDelivery.includes(:message, :child, :profile)
  end
end
