module Api
  class MessagesController < ApplicationController
    before_action :authenticate_user!
    before_action :deny_admin_site_user_access_on_public_site
    before_action :check_profile_status

    def show
      message = MessageDeliveries::MessageDelivery.find(params[:id])
      render json: message
    end

    def default_serializer_options
      { root: false }
    end
  end
end
