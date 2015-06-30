class Admin::CategoriesController < Admin::AdminController
  load_and_authorize_resource
  defaults resource_class: Category

  def permitted_params
    params.permit(category: [:name, :parent_category_id, :show_in_home,
                             :title, :subtitle, :text, :picture_id,
                             :category_image_text, :position_in_home, :color,
                             :second_color])
  end
end
