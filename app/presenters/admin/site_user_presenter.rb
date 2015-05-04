class Admin::SiteUserPresenter < Carnival::BaseAdminPresenter
  model_name 'User'

  field :id,
        actions: [:index, :show], sortable: false

  field :email,
        actions: [:index, :show], sortable: true,
        advanced_search: { operator: :like }

  field :profile_name,
        actions: [:index, :show]

  field :profile_birth_date,
        actions: [:show]

  field :profile_state,
        actions: [:show]

  field :profile_city,
        actions: [:show]

  field :profile_street,
        actions: [:show]

  field :profile_primary_cell_phone_number,
        actions: [:show]

  field :profile_authorized_receive_sms?,
        actions: [:show, :index]

  action :show

  action :impersonate

  action :authorize_receive_sms

  action :unauthorize_receive_sms

  def render_action?(record, record_action, _page_action)
    action = record_action.name.to_sym

    case action
    when :authorize_receive_sms
      !record.profile_authorized_receive_sms?
    when :unauthorize_receive_sms
      record.profile_authorized_receive_sms?
    else
      true
    end
  end
end
