
class Admin::MessagePresenter < Carnival::BaseAdminPresenter

  field :id,
    actions: [:index, :show], :sortable => false,
    advanced_search: {:operator => :equal}

  field :text,
    actions: [:index, :new, :edit, :show],
    advanced_search: {:operator => :like}

  field :gender,
    as: :enum,
    actions: [:index, :new, :edit, :show],
    advanced_search: {:operator => :equal}

  field :teenage_pregnancy,
    actions: [:index, :new, :edit, :show],
    advanced_search: {:operator => :equal}

  field 'category.name',
    actions: [:show, :index],
    advanced_search: {:operator => :equal}

  field :category_id,
    actions: [:new, :edit],
    as: :category_grouped_select

  field :baby_target_type,
    actions: [:index, :new, :edit, :show],
    advanced_search: {:operator => :equal},
    as: :enum

  field :minimum_valid_week,
    actions: [:index, :new, :edit, :show],
    advanced_search: {:operator => :equal}

  field :maximum_valid_week,
    actions: [:index, :new, :edit, :show],
    advanced_search: {:operator => :equal}



  field :created_at, :actions => [:index, :show]

  action :show
  action :edit
  action :destroy
  action :new

end
