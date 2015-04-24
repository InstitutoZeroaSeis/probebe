require 'rails_helper'

RSpec.describe Api::DeviceRegistrationsController, :type => :controller do
  describe "POST create"  do

    context "unauthenticated" do
      it "is not expected to insert a new device register without authenticating" do
        post_data = { device_registration: build(:device_registration_hash) }

        post :create, post_data, format: :json

        expect(response.status).to eq(403)
      end
    end

    context "authenticated" do
      before :each do
        @user = create(:user, :with_profile, :site_user)
        authenticate_through_headers(@user.email, @user.password)
      end

      it "is expected to create a registration with the given device for the appropriate user" do
        registration = build(:device_registration_hash)
        post_data = { device_registration: registration }

        post :create, post_data, format: :json

        registration_response = JSON.parse(response.body).symbolize_keys
        expect(registration_response[:errors]).to be_nil
        expect(registration_response[:platform]).to eq(registration[:platform])
      end

      it "is expected to associate the current user with the given device" do
        registration = build(:device_registration_hash)

        post_data = { device_registration: registration }
        post :create, post_data, format: :json

        registration_response = JSON.parse(response.body).symbolize_keys
        expect(registration_response[:errors]).to be_nil
        expect(registration_response[:platform]).to eq(registration[:platform])
        expect(registration_response[:profile_id]).to eq(@user.profile.id)
      end

      it "is expected to not duplicate an existing device registration" do
        registration = create(:device_registration, profile: @user.profile)

        post_data = { device_registration: registration.attributes.slice('platform', 'platform_code') }
        post :create, post_data, format: :json

        expect(response.status).to eq(304)
        expect(@user.profile.device_registrations.count).to eq(1)
      end

      it "is expected to create many devices" do
        create(:device_registration, profile: @user.profile)
        registration = build(:device_registration_hash)
        post_data = { device_registration: registration }

        post :create, post_data, format: :json

        expect(response.status).to eq(200)
        expect(@user.profile.device_registrations.count).to eq(2)
      end
    end
  end

  describe "GET show" do
    before(:each) do
      user = create(:user, :site_user, :with_profile)
      authenticate_through_headers(user.email, user.password)
    end

    it "is expected to return nil if a device is not yet registered" do
      get :show, platform_code: 'invalid_id', format: :json

      expect(response.status).to eq(404)
    end

    it "is expected to return the registration if it exists" do
      registration = create(:device_registration)

      get :show, platform_code: registration.platform_code, format: :json

      registration_response = JSON.parse(response.body).symbolize_keys
      expect(registration_response[:platform_code]).to eq(registration.platform_code)
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      user = create(:user, :site_user, :with_profile)
      authenticate_through_headers(user.email, user.password)
    end

    it "is expected to destroy the device registrations when signing out" do
      device = create(:device_registration, :with_profile)
      expect(MessageDeliveries::DeviceRegistration.all).to_not be_empty

      delete :destroy, platform_code: device.platform_code, format: :json

      expect(response.status).to eq(200)
      expect(MessageDeliveries::DeviceRegistration.all).to be_empty
    end
  end
end
