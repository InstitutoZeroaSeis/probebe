class Admin::AuthorsController < Carnival::BaseAdminController
  defaults resource_class: Authors::Author

  protected

  def permitted_params
    params.permit(authors_author: [
      :name, :bio, :photo
    ])
  end
end
