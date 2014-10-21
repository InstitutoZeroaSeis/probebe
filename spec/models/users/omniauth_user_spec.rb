require 'spec_helper'

describe Users::OmniauthUser do
  let(:auth_info) { create(:omniauth_hash) }
  subject { Users::OmniauthUser.new(auth_info) }

  context "with an existing user identified by its email" do
    it "should find return the existing user" do
      user = create(:user, email: auth_info.email)
      expect(subject.build_user).to eq(user)
    end
  end

  context "with no existing user" do
    it "should create a new user with the info provided by the external provider" do
      expect(User).to receive(:new).and_call_original
      subject.build_user
    end
  end
end
