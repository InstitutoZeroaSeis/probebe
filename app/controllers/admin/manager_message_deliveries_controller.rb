class Admin::ManagerMessageDeliveriesController < Admin::AdminController
  layout 'carnival/admin'
  defaults resource_class: MessageDeliveries::ManagerMessageDeliveries

end
