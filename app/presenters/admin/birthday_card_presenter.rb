class Admin::BirthdayCardPresenter < Carnival::BaseAdminPresenter

  field :id

  field :age,
    actions: [:index, :show, :new, :edit]

  field :type, as: :enum,
    actions: [:index, :show, :new, :edit]

  field :text,
    actions: [:index, :show, :new, :edit]

  field :avatar,
    actions: [:new, :edit, :show]

  action :new
  action :edit
  action :show
end
