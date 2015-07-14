class Admin::PostPresenter < Carnival::BaseAdminPresenter
  model_name 'Articles::ArticleWithImageCover'

  field :id,
        actions: [:index, :show], sortable: true,
        advanced_search: { operator: :equal }

  field :original_author,
        actions: [:new, :edit],
        advanced_search: { operator: :like }

  field :category_id,
        actions: [:new, :edit],
        as: :partial

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

  field :publishable,
        actions: [:new, :edit, :show],
        sortable: true

  field :intro_text,
        actions: [:new, :edit, :show],
        sortable: true

  field :original_author_name,
        actions: [:index, :show],
        sortable: true,
        advanced_search: { operator: :like }

  field :created_at, actions: [:index, :show]

  action :new
  action :show
  action :edit
  action :destroy
end
