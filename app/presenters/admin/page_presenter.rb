class Admin::PagePresenter < Carnival::BaseAdminPresenter
  model_name 'Site::Page'

  field :title,
    as: :ckeditor,
    actions: [:index, :show, :new, :edit]

  field :subtitle,
    as: :ckeditor,
    actions: [:index, :show, :new, :edit]

  field :text,
    as: :ckeditor,
    actions: [:index, :show, :new, :edit]

  action :destroy
  action :show
  action :edit
  action :new

end
