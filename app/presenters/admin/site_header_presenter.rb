class Admin::SiteHeaderPresenter < Carnival::BaseAdminPresenter

  field :path,
    actions: [:index, :show, :new, :edit]

  field :picture_partial,
    actions: [:edit],
    as: :partial

  action :show
  action :edit

end
