class Admin::SiteBannerPresenter < Carnival::BaseAdminPresenter
  model_name 'SiteBannerDecorator'
  field :banner_type,
    actions: [:index, :show]

  field :banner_type_edit,
    actions: [:edit], as: :partial

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
