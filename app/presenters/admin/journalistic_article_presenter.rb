class Admin::JournalisticArticlePresenter < Carnival::BaseAdminPresenter

  model_name 'Articles::JournalisticArticle'

  field :parent_article_id,
    as: :hidden,
    actions: [:index, :show, :new],
    sortable: true,
    advanced_search: {operator: :equal}

  field :original_author_id,
    as: :admin_site_user_collection,
    actions: [:new, :edit],
    advanced_search: {operator: :like}

  field 'category.name',
    actions: [:show, :index],
    advanced_search: {operator: :equal}

  field :category,
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

  field :image_cover,
    as: :partial,
    actions: [:edit, :new]

  field :summary,
    actions: [:index, :show, :edit, :new],
    sortable: true,
    advanced_search: {operator: :like}

  field :box,
    actions: [:index, :show, :edit, :new],
    sortable: true,
    advanced_search: {operator: :like}

  field :gender,
    actions: [:index, :new, :edit, :show],
    advanced_search: {:operator => :equal},
    as: :enum

  field :teenage_pregnancy,
    actions: [:index, :new, :edit, :show],
    advanced_search: {:operator => :equal}

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

  field :publishable,
    actions: [:index, :new, :edit, :show],
    sortable: true

  field 'original_author_name',
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
