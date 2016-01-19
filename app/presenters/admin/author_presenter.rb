class Admin::AuthorPresenter < Carnival::BaseAdminPresenter
  model_name 'Authors::Author'

  field :id, actions: [:index, :show]

  field :name, actions: [:index, :show, :new, :edit]

  field :bio, actions: [:show, :new, :edit]

  field :photo, actions: [:index, :show, :new, :edit]

  action :new
  action :edit
  action :show
  action :destroy
end
