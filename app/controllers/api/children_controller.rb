module Api
  class ChildrenController < ApplicationController
    before_action :authenticate_user!
    before_action :deny_admin_site_user_access_on_public_site
    before_action :check_profile_status

    def index
      children = current_profile.children
      render json: children, root: false
    end
  end
end
