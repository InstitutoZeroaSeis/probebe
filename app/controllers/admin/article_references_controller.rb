class Admin::ArticleReferencesController < Carnival::BaseAdminController
  load_and_authorize_resource class: 'Articles::ArticleReference'

end
