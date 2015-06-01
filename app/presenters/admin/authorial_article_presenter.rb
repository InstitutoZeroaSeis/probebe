class Admin::AuthorialArticlePresenter < Carnival::BaseAdminPresenter
  model_name 'Articles::AuthorialArticle'

  field :id,
        actions: [:index, :show], sortable: true,
        advanced_search: { operator: :equal }

  field 'category.name',
        actions: [:show, :index],
        advanced_search: { operator: :equal }

  field :category_id,
        actions: [:new, :edit],
        as: :subcategories_collection

  field :tags,
        actions: [:new, :show, :edit],
        nested_form: true,
        nested_form_modes: [:associate],
        show_as_list: true

  field :title,
        actions: [:index, :show, :edit, :new],
        sortable: true,
        advanced_search: { operator: :like }

  field :text,
        as: :ckeditor,
        actions: [:show, :edit, :new],
        sortable: true

  field :summary,
        actions: [:index, :show, :edit, :new],
        sortable: true,
        advanced_search: { operator: :like }

  field :gender,
        as: :enum,
        actions: [:index, :new, :edit, :show],
        advanced_search: { operator: :equal }

  field :teenage_pregnancy,
        actions: [:index, :new, :edit, :show],
        advanced_search: { operator: :equal }

  field :baby_target_type,
        actions: [:index, :new, :edit, :show],
        advanced_search: { operator: :equal },
        as: :enum

  field :minimum_valid_week,
        actions: [:index, :new, :edit, :show],
        advanced_search: { operator: :equal }

  field :maximum_valid_week,
        actions: [:index, :new, :edit, :show],
        advanced_search: { operator: :equal }

  field :article_references,
        actions: [:new, :show, :edit],
        nested_form: true,
        nested_form_modes: [:new],
        nested_form_allow_destroy: true

  field 'user.email',
        actions: [:index, :show],
        sortable: true,
        advanced_search: { operator: :like }

  field :journalistic_articles_count,
        actions: [:index, :show],
        sortable: true

  field :messages,
        actions: [:new, :show, :edit],
        nested_form: true,
        nested_form_modes: [:new]

  field :journalistic_articles,
        actions: [:index, :show],
        show_as_list: true,
        sortable: false

  field :created_at, actions: [:index, :show]

  action :show
  action :edit
  action :destroy
  action :new
  action :create_journalistic_article

  index_as :list
end
