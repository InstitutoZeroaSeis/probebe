require 'rails_helper'

RSpec.describe MessageDeliveries::DeviceRegistration, :type => :model do
  describe "#create" do
    context "when profile is recipient" do
      it "should change profile to prossible_donor" do
        profile = create(:profile, profile_type: Profile.profile_types[:recipient])

        device_registration = MessageDeliveries::
                                DeviceRegistration.create({
                                    profile: profile,
                                    platform_code: '111',
                                    platform: 'platform'
                                })

        expect(profile.possible_donor?).to be == true
      end
    end
  end
end
