class Admin::AvatarPresenter < Carnival::BaseAdminPresenter
  field :id

  field :photo,
    actions: [:new, :edit]

end
