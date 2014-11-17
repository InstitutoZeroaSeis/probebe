require 'rails_helper'
require 'cancan/matchers'

describe "User" do
  describe "abilities" do
    subject(:ability) { Ability.new(user) }
    context "when is an admin" do
      let(:user) { build_stubbed(:user, :admin) }
      it { is_expected.to have_abilities(:manage, :all) }
    end

    context "when is an author" do
      let(:user) { build_stubbed(:user, :author) }
      let(:own_authorial_article) { build_stubbed(:authorial_article, user: user) }
      let(:other_authorial_article) { build_stubbed(:authorial_article) }

      it { is_expected.to have_abilities([:read, :create], Articles::AuthorialArticle) }
      it { is_expected.to have_abilities({update: true, destroy: false}, own_authorial_article) }
      it { is_expected.to not_have_abilities([:update, :destroy], other_authorial_article) }

      it { is_expected.to have_abilities({read: true, update: false, destroy: false}, Articles::JournalisticArticle) }
      it { is_expected.to have_abilities({read: true, update: false, destroy: false}, Message) }
      it { is_expected.to have_abilities({read: true, update: false, destroy: false}, Category) }
      it { is_expected.to have_abilities({read: false, update: false, destroy: false}, User) }
    end

    context "when is an journalist" do
      let(:user) { build_stubbed(:user, :journalist) }

      it { is_expected.to have_abilities([:read, :create, :update], Articles::JournalisticArticle) }
      it { is_expected.to not_have_abilities(:destroy, Articles::JournalisticArticle) }

      it { is_expected.to have_abilities({read: true, create_journalistic_article: true, update: false, destroy: false}, Articles::AuthorialArticle) }
      it { is_expected.to have_abilities({read: true, update: false, destroy: false}, Message) }
      it { is_expected.to have_abilities({read: true, update: false, destroy: false}, Category) }
      it { is_expected.to have_abilities({read: false, update: false, destroy: false}, User) }
    end
  end
end
