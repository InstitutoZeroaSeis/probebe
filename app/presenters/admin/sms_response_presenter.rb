class Admin::SmsResponsePresenter < Carnival::BaseAdminPresenter
  model_name 'SmsResponse'

  field :id,
    actions: [:index, :show]

  field 'donor.email',
    actions: [:index, :show]

  field 'recipient.email',
        actions: [:index, :show]

  field :text,
        actions: [:index, :show]
end
