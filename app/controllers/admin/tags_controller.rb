class Admin::TagsController < Admin::AdminController
  load_and_authorize_resource class: 'Tag'
  defaults resource_class: Tag

  private

  def permitted_params
    params.permit(tag: [:name])
  end

end
