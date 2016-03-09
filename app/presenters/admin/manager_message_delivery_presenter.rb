class Admin::ManagerMessageDeliveryPresenter < Carnival::BaseAdminPresenter

  field :id,
    actions: [:index],
    :sortable => {:direction => :desc, :default => true}

  field :messages_created_start,
    actions: [:index]

  field :messages_sent_end,
    actions: [:index]

  field :sum_messages_created,
    actions: [:index]

  field :sum_messages_sent,
    actions: [:index]

  field :sum_messages_sent_by_sms,
    actions: [:index]

  field :sum_messages_sent_by_android,
    actions: [:index]

  field :sum_messages_sent_by_ios,
    actions: [:index]

  def model_class
    MessageDeliveries::ManagerMessageDeliveries
  end

  def full_model_name
    model_class.to_s
  end

end
