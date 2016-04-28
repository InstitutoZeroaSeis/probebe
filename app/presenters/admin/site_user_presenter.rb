class Admin::SiteUserPresenter < Carnival::BaseAdminPresenter
  model_name 'User'

  field :id,
        :sortable => {:direction => :desc, :default => true},
        actions: [:index, :show]

  field :email,
        actions: [:index, :show, :edit], sortable: true

  field 'profile.name',
        actions: [:index, :show]

  field 'profile.cell_phone'

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

  field 'profile.cell_phone_system',
        actions: [:show]

  field 'profile.profile_type',
        actions: [:show]


  field :profile_edit,
        actions: [:edit],
        as: :partial

  field :children,
        actions: [:show],
        as: :partial

  field :sms_buttons,
        actions: [:show, :edit],
        as: :partial

  field :active_buttons,
        actions: [:show, :edit],
        as: :partial

  field :search_column,
        advanced_search: { operator: :like }


  action :show
  action :edit
  action :impersonate
  action :authorize_receive_sms,
         :remote => true,
         :method => 'GET'

  action :unauthorize_receive_sms,
         :remote => true,
         :method => 'GET'

  scope :all
  scope :children_with_invalid_age
  scope :donor
  scope :completed_profile
  scope :paid_sms
  scope :donated_sms
  scope :with_device_android
  scope :with_device_ios
  scope :unauthorized_receive_sms
  scope :disabled

  def render_action?(record, record_action, _page_action)
    action = record_action.name.to_sym

    case action
    when :authorize_receive_sms
      record.profile.cell_phone.present? &&
      record.profile.children.count > 0 &&
      !record.profile.authorized_receive_sms?
    when :unauthorize_receive_sms
      record.profile.cell_phone.present? &&
      record.profile.children.count > 0 &&
      record.profile.authorized_receive_sms?
    else
      true
    end
  end
end
