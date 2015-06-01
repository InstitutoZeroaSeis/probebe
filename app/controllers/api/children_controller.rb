module Api
  class ChildrenController < ApplicationController
    include HeaderAuthenticationConcern

    def index
      children = current_profile.children
      render json: children, root: false
    end
  end
end
