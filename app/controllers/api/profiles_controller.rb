module Api
  class ProfilesController < ApplicationController
    include HeaderAuthenticationConcern

    def index
      render json: current_profile, root: false
    end

    def update_max_recipient_children
      current_profile.donor! if params[:max_recipient_children].to_i > 0
      current_profile.max_recipient_children = params[:max_recipient_children]
      current_profile.save
      head 200
    end
  end
end
