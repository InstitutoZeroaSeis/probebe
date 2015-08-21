class Admin::SiteMobileImagePresenter < Carnival::BaseAdminPresenter

  field :name,
    actions: [:index, :show, :new, :edit]

  field :title,
    actions: [:index, :show, :new, :edit]

  field :text,
    actions: [:index, :show, :new, :edit]

  field :picture_partial,
    actions: [:edit],
    as: :partial

  action :show
  action :edit

end
