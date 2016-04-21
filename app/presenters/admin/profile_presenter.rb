class Admin::ProfilePresenter < Carnival::BaseAdminPresenter

  field :id

  field :name,
    actions: [:index, :new, :edit],
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

  field :cell_phone,
    actions: [:index, :show, :new, :edit]

  field :role,
        actions: [:edit],
        as: :partial

  field :avatar,
    actions: [:new, :edit],
    nested_form: true,
    nested_form_allow_destroy: true,
    nested_form_modes: [:new, :edit]

  field :children,
        actions: [:show],
        as: :partial

end
