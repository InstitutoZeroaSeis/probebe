class Admin::SiteUserPresenter < Carnival::BaseAdminPresenter
  model_name 'User'

  field :id,
        actions: [:index, :show], sortable: false

  field :email,
        actions: [:index, :show], sortable: true,
        advanced_search: { operator: :like }

  field 'profile.name',
        actions: [:index, :show]

  field 'profile.birth_date',
        actions: [:show]

  field 'profile.state',
        actions: [:show]

  field 'profile.city',
        actions: [:show]

  field 'profile.street',
        actions: [:show]

  field 'profile.primary_cell_phone_number',
        actions: [:show]

  field :confirmation_sent_at,
        :sortable => {:direction => :desc, :default => true}

  field :children,
        actions: [:show],
        as: :partial

  action :show
  action :impersonate
  action :authorize_receive_sms,
         :remote => true,
         :method => 'GET'

  action :unauthorize_receive_sms,
         :remote => true,
         :method => 'GET'

  scope :authorized_receive_sms
  scope :unauthorized_receive_sms

  def render_action?(record, record_action, _page_action)
    action = record_action.name.to_sym

    case action
    when :authorize_receive_sms
      !record.profile.authorized_receive_sms?
    when :unauthorize_receive_sms
      record.profile.authorized_receive_sms?
    else
      true
    end
  end
end
