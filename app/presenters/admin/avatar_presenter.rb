class Admin::AvatarPresenter < Carnival::BaseAdminPresenter
  field :id

  field :photo,
    as: :admin_previewable_file,
    actions: [:new, :edit]

end
