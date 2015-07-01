class Admin::SiteBannerPresenter < Carnival::BaseAdminPresenter
  model_name 'SiteBannerDecorator'

  field :position

  field :name,
    actions: [:index, :show, :new, :edit]

  field :title,
    actions: [:index, :show, :edit]

  field :text,
    actions: [:index, :show, :edit]

  field :picture_partial,
    actions: [:edit],
    as: :partial

  action :show
  action :edit

end
