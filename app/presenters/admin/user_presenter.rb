class Admin::UserPresenter < Carnival::BaseAdminPresenter

  field :id,
        actions: [:index, :show], :sortable => false

  field :email,
        actions: [:index, :show, :new, :edit], :sortable => true,
        advanced_search: {:operator => :like}

  field :role,
        actions: [:index, :show, :new, :edit], sortable: true,
        as: :enum


  action :show
  action :new
  action :impersonate,
          remote: :false,
          method: 'POST'

end
