module Api
  class ChildrenController < ApplicationController
    before_filter :authenticate_user!
    before_filter :deny_admin_site_user_access_on_public_site
    before_filter :check_profile_status

    def index
      children = current_profile.children
      render json: children, root: false
    end
  end
end
