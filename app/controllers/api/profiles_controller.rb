module Api
  class ProfilesController < ApplicationController
    include HeaderAuthenticationConcern
    skip_before_action :verify_authenticity_token
    protect_from_forgery with: :null_session
    before_action :instantiate_profile
    respond_to :json

    def index
      render json: current_profile, root: false
    end

    def update
      if update_password_and_profile
        sign_in @user, bypass: true
        render json: {message: "ok"}
      else
        @profile.errors.add(:base, @user.errors.full_messages.first) if !@user.change_omniauth_password?
       render json: {message: @profile.errors}
      end
    end

    protected

    def update_password_and_profile
      if @user.change_omniauth_password?
        result = @profile.update_attributes(permitted_params)
      else
        password = params[:profile][:user][:password] || ""
        result =  @user.update_attributes password: password,
                                change_omniauth_password: true,
                                profile_attributes: permitted_params.merge(id: @profile.id)
      end

      Users::SmsMessageSender.send_completed_profile_msg(@user) if result
      result
    end

    def instantiate_profile
      @profile = ProfilePresenter.new(current_profile)
      @user = @profile.user
    end

    def permitted_params
      profile_params = params[:profile]
      personal_attributes = [:name, :gender, :birth_date, :cell_phone_system, avatar_attributes: [:id, :photo]]
      mother_attributes = [children_attributes: [:id, :_destroy, :name, :born, :birth_date, :gender, avatar_attributes: [:id, :photo]]]
      contact_attributes = [:state, :city, :street, :postal_code, :address_complement, :cell_phone]

      profile_params ? profile_params.permit(personal_attributes + mother_attributes + contact_attributes) : {}
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
