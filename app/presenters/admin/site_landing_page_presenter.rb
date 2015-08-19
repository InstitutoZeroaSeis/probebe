class Admin::SiteLandingPagePresenter < Carnival::BaseAdminPresenter

  field :title,
    as: :ckeditor,
    actions: [:index, :show, :new, :edit]

  field :text,
    as: :ckeditor,
    actions: [:index, :show, :new, :edit]

  field :picture_partial,
    actions: [:edit],
    as: :partial

  action :show
  action :edit

end
