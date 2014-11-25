class Admin::ArticleReferencesController < Admin::AdminController
  load_and_authorize_resource class: 'Articles::ArticleReference'
end
