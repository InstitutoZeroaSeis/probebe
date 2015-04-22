module Api
  class ChildrenController < ApplicationController
    before_action :authenticate_user!

    def index
      children = current_profile.children
      render json: children, root: false
    end
  end
end
