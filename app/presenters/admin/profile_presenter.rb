class Admin::ProfilePresenter < Carnival::BaseAdminPresenter

  field :id

  field :user_id,
    as: :hidden,
    actions: [:new]

  field :name,
    actions: [:index, :show]

  field :first_name,
    actions: [:new, :edit],
    sortable: true,
    advanced_search: {operator: :equal}

  field :last_name,
    actions: [:new, :edit],
    sortable: true,
    advanced_search: {operator: :equal}

  field :birth_date,
    actions: [:index, :show, :new, :edit]

  field :state,
    actions: [:index, :show, :new, :edit]

  field :city,
    actions: [:index, :show, :new, :edit]

  field :street,
    actions: [:index, :show, :new, :edit]

  field 'primary_cell_phone_number',
    actions: [:index, :show]

  field :cell_phones,
    actions: [:new, :edit],
    nested_form: true,
    nested_form_allow_destroy: true,
    nested_form_modes: [:new, :edit]

  field :avatar,
    actions: [:new, :edit],
    nested_form: true,
    nested_form_allow_destroy: true,
    nested_form_modes: [:new, :edit]

end
