module Api
  class CategoriesController < ApplicationController
    include HeaderAuthenticationConcern

    def index
      categories = Category.base_categories
      render json: categories, root: false
    end
  end
end
