class Admin::MessageDeliveryPresenter < Carnival::BaseAdminPresenter

  field :id

  field 'profile.name',
    actions: [:index, :show],
    searchable: false

  field 'profile_cell_phone',
    actions: [:csv]

  field 'message.text',
    actions: [:index, :show, :csv],
    advanced_search: {operator: :like}

  field :delivery_date,
    advanced_search: {operator: :equal},
    actions: [:new, :show, :index]

  action :csv

  def model_class
    MessageDeliveries::MessageDelivery
  end

  def full_model_name
    model_class.to_s
  end

end
