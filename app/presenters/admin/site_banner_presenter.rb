class Admin::SiteBannerPresenter < Carnival::BaseAdminPresenter
  model_name 'SiteBannerDecorator'

  field :position

  field :name,
    actions: [:index, :show, :new, :edit]

  field :title,
    actions: [:index, :show, :edit]

  field :text,
    actions: [:index, :show, :edit]

  field :background_image,
        as: :admin_previewable_file,
    actions: [:show, :edit]

  action :show
  action :edit

end
