class Admin::PartnerPresenter < Carnival::BaseAdminPresenter
  model_name 'Partner'

  field :name,
    actions: [:index, :show, :new, :edit]

  field :text,
    as: :ckeditor,
    actions: [:index, :show, :edit, :new]

  field :images_partial,
    actions: [:new, :edit],
    as: :partial


  action :show
  action :edit
  action :new

end
