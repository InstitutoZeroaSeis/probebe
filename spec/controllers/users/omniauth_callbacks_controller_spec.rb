require 'rails_helper'
require Rails.root.join('spec/stubs/stubbed_hash.rb')

RSpec.describe Users::OmniauthCallbacksController do
  before { @request.env["devise.mapping"] = Devise.mappings[:user] }

  describe "#authenticate_user" do
    context "with a new user" do
      let (:omni_auth_hash) { OmniAuthHashWrapper.new(OmniAuth::StubbedHash) }

      it "should authenticate and redirect to the user profile page" do
        allow(OmniAuthHashWrapper).to receive(:new).and_return(omni_auth_hash)
        expect(subject).to receive(:sign_in)
        expect(subject).to receive(:redirect_to)

        subject.authenticate_user
      end
    end

    context "with an existing user" do
      let (:omni_auth_hash) { OmniAuthHashWrapper.new(OmniAuth::StubbedHash) }

      it "should authenticate and redirect an existing user to the home page" do
        create(:user, :with_profile, email: omni_auth_hash.email)
        allow(OmniAuthHashWrapper).to receive(:new).and_return(omni_auth_hash)
        expect(subject).to receive(:sign_in_and_redirect)

        subject.authenticate_user
      end
    end
  end
end
