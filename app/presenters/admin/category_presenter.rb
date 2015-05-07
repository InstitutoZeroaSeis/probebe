class Admin::CategoryPresenter < Carnival::BaseAdminPresenter
  model_name 'CategoryTranslationDecorator'

  field :id,
        actions: [:index, :show], :sortable => false,
        advanced_search: { operator: :equal }

  field :parent_category,
        as: :enum,
        actions: [:edit, :new]

  field 'parent_category.name',
        as: :enum,
        actions: [:index, :show]

  field :name,
        actions: [:index, :show, :edit, :new],
        sortable: false,
        advanced_search: { operator: :like }

  action :show
  action :edit
  action :destroy
  action :new

end
