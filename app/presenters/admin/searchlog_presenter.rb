class Admin::SearchlogPresenter < Carnival::BaseAdminPresenter
  model_name 'Searchlog'

  field :id,
    actions: [:index, :show]

  field :text,
    actions: [:index, :show]

  field 'user.email',
        actions: [:index, :show]

  action :show
end
