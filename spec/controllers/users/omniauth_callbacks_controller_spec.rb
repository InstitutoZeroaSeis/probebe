require Rails.root.join('spec/stubs/stubbed_hash.rb')

describe Users::OmniauthCallbacksController do
  before { @request.env["devise.mapping"] = Devise.mappings[:user] }

  describe "#authenticate_user" do
    context "with valid authentcation info" do
      let (:omni_auth_hash) { OmniAuthHashWrapper.new(OmniAuth::StubbedHash) }

      it "should authenticate and sign in a user" do
        allow(OmniAuthHashWrapper).to receive(:new).and_return(omni_auth_hash)
        expect(subject).to receive(:sign_in_and_redirect)

        subject.authenticate_user
      end
    end

    context "with invalid authentication info" do
      let (:omni_auth_hash) { OmniAuthHashWrapper.new(OmniAuth::MissingNameHash) }

      it "should redirect the user to the profile page if the profile is not complete" do
        allow(OmniAuthHashWrapper).to receive(:new).and_return(omni_auth_hash)
        expect(subject).to receive(:sign_in)
        expect(subject).to receive(:render)

        subject.authenticate_user
      end
    end
  end
end
