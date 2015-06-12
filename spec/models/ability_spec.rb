require 'rails_helper'
require 'cancan/matchers'

describe "User" do
  describe "abilities" do
    subject(:ability) { Ability.new(user) }
    context "when is an admin" do
      let(:user) { build_stubbed(:user, :admin) }
      it { is_expected.to have_abilities(:manage, :all) }
    end

    context "when is an journalist" do
      let(:user) { build_stubbed(:user, :journalist) }

      it { is_expected.to have_abilities([:read, :create, :update], Articles::Article) }
      it { is_expected.to not_have_abilities(:destroy, Articles::Article) }
      it { is_expected.to have_abilities({read: true, update: false, destroy: false}, Message) }
      it { is_expected.to have_abilities({create: true, read: true, update: true, destroy: false}, Category) }
      it { is_expected.to have_abilities({create: true, read: true, update: true, destroy: false}, Tag) }
      it { is_expected.to have_abilities({read: false, update: false, destroy: false}, User) }
    end

    context "when is an site user" do
      let(:user) { build_stubbed(:user, :site_user, :with_profile) }
      let(:child) { build_stubbed(:child, profile: user.profile) }

      it { is_expected.to have_abilities({show: true}, Child) }
      it { is_expected.to have_abilities({create: true, read: true, update: true, destroy: false}, Profile) }
    end
  end
end
