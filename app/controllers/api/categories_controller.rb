module Api
  class CategoriesController < ApplicationController
    include HeaderAuthenticationConcern

    def index
      categories = Category.all
      render json: categories, root: false
    end
  end
end
