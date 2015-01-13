class Admin::CellPhonePresenter < Carnival::BaseAdminPresenter

  field :id

  field :area_code,
    actions: [:new, :edit]

  field :number,
    actions: [:new, :edit]

end
