class Admin::EnginePresenter < Carnival::BaseAdminPresenter
  model_name 'Engine'

  field :authorize_receive_sms,
    actions: [:index, :edit]

  action :edit
end
