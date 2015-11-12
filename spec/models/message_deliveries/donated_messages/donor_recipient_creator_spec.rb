require 'rails_helper'

RSpec.describe MessageDeliveries::DonatedMessages::DonorRecipientCreator do
  describe "#create" do
    context "when profile do not have donations children" do
      it "should choose recipient children for the profile" do
        profile = create(:profile, profile_type: Profile.profile_types[:donor], max_recipient_children: 2)
        recipient_profile = create(:profile, profile_type: Profile.profile_types[:recipient])
        create(:child, profile: recipient_profile)
        create(:child, profile: recipient_profile)

        MessageDeliveries::DonatedMessages::DonorRecipientCreator.create(profile)
        profile.reload

        expect(profile.donations_children.size).to be == 2
      end
    end

    context "when profile already has a donation children" do
      it "should choose recipient children for the profile" do
        profile = create(:profile, profile_type: Profile.profile_types[:donor], max_recipient_children: 2)
        recipient_profile = create(:profile, profile_type: Profile.profile_types[:recipient])
        create(:child, profile: recipient_profile, donor: profile)
        create(:child, profile: recipient_profile)

        MessageDeliveries::DonatedMessages::DonorRecipientCreator.create(profile)
        profile.reload

        expect(profile.donations_children.size).to be == 2
      end
    end

    context "when profile already reached the max donations children" do
      it "should not choose recipient children for the profile" do
        profile = create(:profile, profile_type: Profile.profile_types[:donor], max_recipient_children: 2)
        recipient_profile = create(:profile, profile_type: Profile.profile_types[:recipient])
        create(:child, profile: recipient_profile, donor: profile)
        create(:child, profile: recipient_profile, donor: profile)

        MessageDeliveries::DonatedMessages::DonorRecipientCreator.create(profile)
        profile.reload

        expect(profile.donations_children.size).to be == 2
      end
    end

    context "when the profile is reducing the donations number" do
      it "should remove one children from the donations list" do
        profile = create(:profile, profile_type: Profile.profile_types[:donor], max_recipient_children: 1)
        recipient_profile = create(:profile, profile_type: Profile.profile_types[:recipient])
        create(:child, profile: recipient_profile, donor: profile)
        create(:child, profile: recipient_profile, donor: profile)

        MessageDeliveries::DonatedMessages::DonorRecipientCreator.create(profile)
        profile.reload

        expect(profile.donations_children.size).to be == 1
      end
    end

    context "when there is a children that already had been a recipient" do
      it "should choose this children instead others that have never been a recipient" do
        profile = create(:profile, profile_type: Profile.profile_types[:donor], max_recipient_children: 2)
        recipient_profile = create(:profile, profile_type: Profile.profile_types[:recipient])
        create(:child, profile: recipient_profile, donor: profile)
        was_recipient = create(:child, profile: recipient_profile, was_recipient_until: DateTime.now)

        MessageDeliveries::DonatedMessages::DonorRecipientCreator.create(profile)
        profile.reload

        expect(profile.donations_children.size).to be == 2
        expect(profile.donations_children.where('children.id = ?', was_recipient.id).size).to be == 1
      end
    end
  end
end
