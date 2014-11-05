class Admin::JournalisticArticlePresenter < Carnival::BaseAdminPresenter

  model_name 'Articles::JournalisticArticle'

  field :id,
        actions: [:index, :show], sortable: true,
        advanced_search: {operator: :equal}

  field :parent_article_id,
        as: :string,
        actions: [:index, :show, :edit, :new],
        sortable: true,
        advanced_search: {operator: :equal}

  field 'category.name',
        actions: [:show, :index],
        advanced_search: {operator: :equal}

  field :category_id,
        actions: [:new, :edit],
        as: :category_grouped_select

  field :title,
        actions: [:index, :show, :edit, :new],
        sortable: true,
        advanced_search: {operator: :like}

  field :text,
        actions: [:index, :show, :edit, :new],
        sortable: true,
        advanced_search: {operator: :like}

  field :summary,
        actions: [:index, :show, :edit, :new],
        sortable: true,
        advanced_search: {operator: :like}

  field :text,
        actions: [:index, :show, :edit, :new],
        sortable: true,
        advanced_search: {operator: :like}

  field 'user.email',
        actions: [:index, :show],
        sortable: true,
        advanced_search: {operator: :like}

  action :show
  action :edit
  action :destroy
  action :new

end