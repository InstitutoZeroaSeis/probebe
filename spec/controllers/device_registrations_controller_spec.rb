require 'rails_helper'

RSpec.describe DeviceRegistrationsController, :type => :controller do
  describe "POST create"  do
    it "is not expected to insert a new device register without authenticating" do
      registration = { "platform" => "android", "platform_code" => "android_platform_code" }
      post_data = { device_registration: registration }
      post :create, post_data, format: :json
      expect(response.status).to eq(403)
    end

    it "is expected to create a registration with the given device for the appropriate user" do
      user = create(:user, :site_user)
      registration = { "platform" => "android", "platform_code" => "android_platform_code" }
      post_data = { email: user.email, password: user.password, device_registration: registration }
      post :create, post_data, format: :json
      registration_response = JSON.parse(response.body).stringify_keys
      expect(registration_response['errors']).to be_nil
      expect(registration_response['platform']).to eq(registration['platform'])
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
      registration_response = JSON.parse(response.body).stringify_keys
      expect(registration_response['platform_code']).to eq(registration.platform_code)
    end
  end
end
