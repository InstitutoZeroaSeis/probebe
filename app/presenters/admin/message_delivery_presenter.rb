class Admin::MessageDeliveryPresenter < Carnival::BaseAdminPresenter

  field :id,
    actions: [:index, :show],
    sortable: false,
    searchable: false

  field 'profile_name',
    actions: [:index, :show],
    searchable: false

  field 'message.text',
    actions: [:index, :show],
    advanced_search: {operator: :like}

  field :delivery_date,
    advanced_search: {operator: :equal},
    actions: [:new, :show, :index]

  field :message_for_test,
    actions: [:new, :show, :index]

  action :show
  action :new

  def model_class
    MessageDeliveries::MessageDelivery
  end

  def full_model_name
    model_class.to_s
  end

end
