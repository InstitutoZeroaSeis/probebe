class Admin::ArticleReferencesController < Carnival::BaseAdminController
  before_filter :authenticate_user!
  load_and_authorize_resource class: 'ArticleReference'

end
