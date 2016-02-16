class Admin::MenuPresenter < Carnival::BaseAdminPresenter

  model_name 'Site::Menu'

  field :id,
        actions: [:index, :show], :sortable => false

  field :parent_menu_select,
        actions: [:edit, :new],
        as: :partial

  field 'parent_menu.name',
        actions: [:index, :show]

  field :name,
        actions: [:index, :show, :edit, :new],
        sortable: false,
        advanced_search: { operator: :like }

  field :position,
        actions: [:new, :edit, :show]

  field 'page.title',
  :actions => [:show, :index]

  field :page_menu_select,
        actions: [:new, :edit],
        as: :partial

  field :link,
        actions: [:new, :edit, :show]

  field :target_blank,
        actions: [:new, :edit, :index, :show]


  action :destroy
  action :edit
  action :new
  action :show
end
