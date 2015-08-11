require 'rails_helper'

describe RecipientDonorWorker do
  it 'should relate a children with a donor' do
    profile = create(:profile, profile_type: Profile.profile_types[:recipient])
    create(:child, profile: profile)
    donor = create(:profile, profile_type: Profile.profile_types[:donor], max_recipient_children: 3)

    RecipientDonorWorker.new.perform

    expect(donor.donations_children.size).to be > 0
  end
end
