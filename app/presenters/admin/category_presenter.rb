class Admin::CategoryPresenter < Carnival::BaseAdminPresenter
  field :id,
        actions: [:index, :show], :sortable => false,
        advanced_search: { operator: :equal }

  field :parent_category_select,
        actions: [:edit, :new], as: :partial

  field 'parent_category.name',
        as: :enum,
        actions: [:index, :show]

  field :name,
        actions: [:index, :show, :edit, :new],
        sortable: false,
        advanced_search: { operator: :like }

  field :show_in_home,
        actions: [:new, :edit, :index, :show]

  field :position_in_home,
        actions: [:new, :edit, :index, :show]

  field :color,
        actions: [:new, :edit, :show],
        as: :color_picker

  field :title,
        as: :ckeditor,
        actions: [:new, :edit, :show]

  field :subtitle,
        as: :ckeditor,
        actions: [:new, :edit, :show]

  field :text,
        as: :ckeditor,
        actions: [:new, :edit, :show]

  field :category_image,
        actions: [:new, :edit, :show],
        as: :admin_previewable_file

  field :category_image_text,
        actions: [:new, :edit, :show]

  action :destroy
  action :edit
  action :new
  action :show

  scope :base_categories
  scope :sub_categories
end
