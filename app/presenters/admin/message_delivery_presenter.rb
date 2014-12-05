class Admin::MessageDeliveryPresenter < Carnival::BaseAdminPresenter

  field :id,
    actions: [:index, :show],
    sortable: false,
    advanced_search: {operator: :equal}

  field :profile_id,
    actions: [:index, :show],
    advanced_search: {operator: :equal}

  field 'profile_name',
    actions: [:index, :show],
    advanced_search: {operator: :like}

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

end
