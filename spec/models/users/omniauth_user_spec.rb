require 'spec_helper'

describe Users::OmniauthUser do
  context "with valid omniauth info" do
    let(:auth_info) { create(:omniauth_hash) }
    let(:user) { create(:user, email: auth_info.email)}
    subject { Users::OmniauthUser.new(auth_info.merge(user: user)) }

    context "with an existing user identified by its email" do
      it "should find return the existing user with its profile filled" do
        expect(subject).to be_valid
        expect(subject.user).to eq(user)

        expect(subject.save).to eq(true)
      end
    end

    context "with no existing user" do
      it "should create a new user with the info provided by the external provider" do
        expect(subject).to be_valid

        subject.save

        expect(subject.user).to be_valid
      end
    end
  end

  context "with invalid omniauth info" do
    subject { Users::OmniauthUser.new({}) }
    it "should not save a user profile" do
      expect(subject).to be_invalid

      subject.save
    end
  end
end
