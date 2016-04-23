class Admin::EnginePresenter < Carnival::BaseAdminPresenter
  model_name 'Engine'

  field :authorize_receive_sms,
    actions: [:index, :edit]

  field :welcame_message,
    actions: [:show, :edit]

  action :edit
end
