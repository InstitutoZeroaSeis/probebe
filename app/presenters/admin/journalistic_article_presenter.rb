class Admin::JournalisticArticlePresenter < Carnival::BaseAdminPresenter

  model_name 'Articles::JournalisticArticle'


  field :parent_article_id,
    as: :hidden,
    actions: [:index, :show, :new],
    sortable: true,
    advanced_search: {operator: :equal}

  field 'category.name',
    actions: [:show, :index],
    advanced_search: {operator: :equal}

  field :category_name,
    as: :readonly,
    actions: [:new, :edit]

  field :tags,
    actions: [:new, :show, :edit],
    nested_form: true,
    nested_form_modes: [:associate],
    show_as_list: true

  field :title,
    actions: [:index, :show, :edit, :new],
    sortable: true,
    advanced_search: {operator: :like}

  field :parent_article_text,
    actions: [:new, :edit],
    as: :readonly_raw

  field :text,
    as: :ckeditor,
    actions: [:show, :edit, :new],
    sortable: true

  field :summary,
    actions: [:index, :show, :edit, :new],
    sortable: true,
    advanced_search: {operator: :like}

  field :gender,
    actions: [:index, :new, :edit, :show],
    advanced_search: {:operator => :equal},
    as: :readonly

  field :teenage_pregnancy,
    actions: [:index, :new, :edit, :show],
    advanced_search: {:operator => :equal},
    as: :readonly

  field :baby_target_type,
    actions: [:index, :new, :edit, :show],
    advanced_search: {:operator => :equal},
    as: :readonly

  field :minimum_valid_week,
    actions: [:index, :new, :edit, :show],
    advanced_search: {:operator => :equal},
    as: :readonly

  field :maximum_valid_week,
    actions: [:index, :new, :edit, :show],
    advanced_search: {:operator => :equal},
    as: :readonly

  field :publishable,
        actions: [:index, :new, :edit, :show],
        sortable: true

  field 'user.email',
    actions: [:index, :show],
    sortable: true,
    advanced_search: {operator: :like}

  field :messages,
    actions: [:new, :show, :edit],
    nested_form: true,
    nested_form_modes: [:new]

  action :show
  action :edit
  action :destroy
  action :show_activity_log

  index_as :list

end
