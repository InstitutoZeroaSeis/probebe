describe Users::OmniauthCallbacksController do
  before { @request.env["devise.mapping"] = Devise.mappings[:user] }

  describe "#authenticate_user" do
    context "with valid authentcation info" do
      let (:auth_info) { create(:omniauth_hash) }

      it "should authenticate and sign in a user" do
        allow(subject).to receive(:omniauth_info).and_return(auth_info)
        expect(subject).to receive(:sign_in_and_redirect)

        subject.authenticate_user
      end
    end

    context "with invalid authentication info" do
      let (:auth_info) { {} }
      it "should redirect the user back to the login page" do
        allow(subject).to receive(:omniauth_info).and_return(auth_info)
        expect(subject).to receive(:redirect_to).with(new_user_session_path)

        subject.authenticate_user

        expect(subject.flash[:alert]).to_not be_nil
      end
    end
  end
end
