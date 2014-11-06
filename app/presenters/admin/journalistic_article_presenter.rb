class Admin::JournalisticArticlePresenter < Carnival::BaseAdminPresenter

  model_name 'Articles::JournalisticArticle'


  field :parent_article_id,
        as: :string,
        actions: [:index, :show, :edit, :new],
        sortable: true,
        advanced_search: {operator: :equal}

  field :id,
        actions: [:index, :show], sortable: true,
        advanced_search: {operator: :equal}

  field 'category.name',
        actions: [:show, :index],
        advanced_search: {operator: :equal}

  field :category_id,
        as: :category_grouped_select,
        actions: [:new, :edit]

  field :tags,
        actions: [:new, :show, :edit],
        nested_form: true,
        nested_form_modes: [:associate]

  field :title,
        actions: [:index, :show, :edit, :new],
        sortable: true,
        advanced_search: {operator: :like}

  field :text,
        as: :ckeditor,
        actions: [:show, :edit, :new],
        sortable: true

  field :summary,
        actions: [:index, :show, :edit, :new],
        sortable: true,
        advanced_search: {operator: :like}

  field :article_references,
        actions: [:new, :show, :edit],
        nested_form: true,
        nested_form_modes: [:new],
        nested_form_allow_destroy: true

  field 'user.email',
        actions: [:index, :show],
        sortable: true,
        advanced_search: {operator: :like}



  action :show
  action :edit
  action :destroy
  action :new

end

