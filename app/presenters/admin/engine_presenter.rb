class Admin::EnginePresenter < Carnival::BaseAdminPresenter
  model_name 'Engine'

  field :authorize_receive_sms,
    actions: [:index, :edit, :index]

  field :welcame_message,
    actions: [:show, :edit, :index]

  field :warning_message_donated,
    actions: [:show, :edit, :index]

  action :edit
end
