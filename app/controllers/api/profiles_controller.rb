module Api
  class ProfilesController < ApplicationController
    include HeaderAuthenticationConcern

    def index
      render json: current_profile, root: false
    end

    def update_max_recipient_children
      if params[:max_recipient_children].to_i > 0
        current_profile.donor!
        current_profile.max_recipient_children = params[:max_recipient_children]
        current_profile.save
        MessageDeliveries::DonatedMessages::
          DonorRecipientCreator.create(current_profile)
      end
      head 200
    end
  end
end
