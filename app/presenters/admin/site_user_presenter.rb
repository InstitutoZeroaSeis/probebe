class Admin::SiteUserPresenter < Carnival::BaseAdminPresenter
  model_name 'User'

  field :id,
        :sortable => {:direction => :desc, :default => true},
        actions: [:index, :show]

  field :email,
        actions: [:index, :show, :edit], sortable: true,
        advanced_search: { operator: :like }

  field 'profile.name',
        actions: [:index, :show],
        advanced_search: { operator: :like }

  field 'profile.cell_phone',
        advanced_search: { operator: :like }

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

  field :profile_edit,
        actions: [:edit],
        as: :partial

  field :children,
        actions: [:show],
        as: :partial

  action :show
  action :edit
  action :impersonate
  action :authorize_receive_sms,
         :remote => true,
         :method => 'GET'

  action :unauthorize_receive_sms,
         :remote => true,
         :method => 'GET'

  scope :completed_profile
  scope :authorized_receive_sms
  scope :unauthorized_receive_sms
  scope :all

  def render_action?(record, record_action, _page_action)
    action = record_action.name.to_sym

    case action
    when :authorize_receive_sms
      record.profile.cell_phone.present? &&
      record.profile.children.size > 0 &&
      !record.profile.authorized_receive_sms?
    when :unauthorize_receive_sms
      record.profile.cell_phone.present? &&
      record.profile.children.size > 0 &&
      record.profile.authorized_receive_sms?
    else
      true
    end
  end
end
