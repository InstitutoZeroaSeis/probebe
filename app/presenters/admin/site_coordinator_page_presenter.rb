class Admin::SiteCoordinatorPagePresenter < Carnival::BaseAdminPresenter

  field :title,
    # as: :ckeditor,
    actions: [:index, :show, :new, :edit]

  field :text,
    # as: :ckeditor,
    actions: [:index, :show, :new, :edit]

  action :show
  action :edit
  action :new
  action :destroy
end
