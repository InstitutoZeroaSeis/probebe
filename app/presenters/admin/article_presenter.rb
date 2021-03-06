class Admin::ArticlePresenter < Carnival::BaseAdminPresenter
  model_name 'Articles::ArticleWithImageCover'

  field :id,
        actions: [:index, :show], sortable: true,
        advanced_search: { operator: :equal }

  field 'category.name',
        actions: [:show, :index],
        advanced_search: { operator: :equal }

  field :original_author,
        actions: [:new, :edit]

  field :category_id,
        actions: [:new, :edit],
        as: :subcategories_collection

  field :tag_names,
        actions: [:new, :show, :edit],
        as: :text_with_tag_data

  field :title,
        actions: [:index, :show, :edit, :new],
        sortable: true,
        advanced_search: { operator: :like }

  field :intro_text,
        actions: [:new, :edit, :show],
        sortable: true

  field :text,
        as: :ckeditor,
        actions: [:show, :edit, :new],
        sortable: true

  field :cover_picture_partial,
    actions: [:new, :edit],
    as: :partial

  field :thumb_picture_partial,
    actions: [:new, :edit],
    as: :partial

  field :gender,
        actions: [:new, :edit, :show],
        advanced_search: { operator: :equal },
        as: :enum

  field :teenage_pregnancy,
        actions: [:new, :edit, :show],
        advanced_search: { operator: :equal }

  field :baby_target_type,
        actions: [:new, :edit, :show],
        advanced_search: { operator: :equal },
        as: :enum

  field :minimum_valid_week,
        actions: [:new, :edit, :show],
        advanced_search: { operator: :equal }

  field :maximum_valid_week,
        actions: [:new, :edit, :show],
        advanced_search: { operator: :equal }

  field :publishable,
        actions: [:new, :edit, :show],
        sortable: true

  field :intro_text,
        actions: [:new, :edit, :show],
        sortable: true

  field 'original_author.name',
        actions: [:index, :show],
        sortable: true,
        advanced_search: { operator: :equal }

  field :messages,
        actions: [:new, :show, :edit],
        nested_form: true,
        nested_form_allow_destroy: true,
        nested_form_modes: [:new]

  field :created_at, actions: [:index, :show],
        :sortable => {:direction => :desc, :default => true}

  action :new
  action :show
  action :edit
  action :destroy
  action :show_activity_log

end
