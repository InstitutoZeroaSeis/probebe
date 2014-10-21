require 'spec_helper'

describe Users::OmniauthUser do
  let(:auth_info) { create(:omniauth_hash) }
  subject { Users::OmniauthUser.new(auth_info) }

  context "with an existing user identified by its email" do
    it "should find return the existing user" do
      user = create(:user, email: auth_info.email)
      expect(User).to_not receive(:create!)
      expect(subject.find_or_create).to eq(user)
    end
  end

  context "with no existing user" do
    it "should create a new user with the info provided by the external provider" do
      expect(User).to receive(:create!).and_call_original
      subject.find_or_create
    end
  end
end
