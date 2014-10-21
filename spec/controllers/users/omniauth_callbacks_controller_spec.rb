describe Users::OmniauthCallbacksController do
  context "with the authentcation info" do
    let(:user) { double('user', skip_confirmation!: nil, save: nil) }
    before { expect(Users::OmniauthUser).to receive(:new).and_return(double(build_user: user))}
    before { expect(subject).to receive(:omniauth_info) }
    it "should authenticate and sign in a user" do
      expect(subject).to receive(:sign_in_and_redirect).with(user, event: :authentication)
      subject.authenticate_user
    end
  end
end
