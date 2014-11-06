class Admin::ArticleReferencePresenter < Carnival::BaseAdminPresenter

  field :id,
        actions: [:index, :show], sortable: true,
        advanced_search: {operator: :equal}

  field :source,
        actions: [:index, :show, :edit, :new], sortable: true,
        advanced_search: {operator: :like}

end