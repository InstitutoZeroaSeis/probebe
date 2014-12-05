require 'rails_helper'

RSpec.describe DeviceRegistrationsController, :type => :controller do
  describe "POST create"  do
    it "is not expected to insert a new device register without authenticating" do
      post_data = { device_registration: build(:device_registration_hash) }

      post :create, post_data, format: :json

      expect(response.status).to eq(403)
    end

    it "is expected to create a registration with the given device for the appropriate user" do
      user = create(:user, :with_profile, :site_user, :confirmed)
      registration = build(:device_registration_hash)
      post_data = { device_registration: registration }

      authenticate_through_headers(user.email, user.password)
      post :create, post_data, format: :json

      registration_response = JSON.parse(response.body).symbolize_keys
      expect(registration_response[:errors]).to be_nil
      expect(registration_response[:platform]).to eq(registration[:platform])
    end

    it "is expected to associate the current user with the given device" do
      user = create(:user, :site_user, :confirmed, :with_profile)
      registration = build(:device_registration_hash)
      authenticate_through_headers(user.email, user.password)

      post_data = { device_registration: registration }
      post :create, post_data, format: :json

      registration_response = JSON.parse(response.body).symbolize_keys
      expect(registration_response[:errors]).to be_nil
      expect(registration_response[:platform]).to eq(registration[:platform])
      expect(registration_response[:profile_id]).to eq(user.profile.id)
    end

    it "is expected to update an existing device registration" do
      user = create(:user, :site_user, :confirmed, :with_profile)
      registration = create(:device_registration, profile: user.profile)
      authenticate_through_headers(user.email, user.password)

      post_data = { device_registration: registration.attributes.slice('platform', 'platform_code') }
      post :create, post_data, format: :json

      registration_response = JSON.parse(response.body).symbolize_keys
      expect(registration_response[:errors]).to be_nil
      expect(registration_response[:id]).to eq(registration.id)
      expect(registration_response[:platform]).to eq(registration.platform)
      expect(registration_response[:profile_id]).to eq(user.profile.id)
    end
  end

  describe "GET show" do
    it "is expected to return nil if a device is not yet registered" do
      get :show, id: 'invalid_id', format: :json
      expect(response.status).to eq(404)
    end

    it "is expected to return the registration if it exists" do
      registration = create(:device_registration)

      get :show, id: registration.platform_code, format: :json

      registration_response = JSON.parse(response.body).symbolize_keys
      expect(registration_response[:platform_code]).to eq(registration.platform_code)
    end
  end
end
