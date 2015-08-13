require 'rails_helper'

RSpec.describe Profile, type: :model do
  it 'is valid with name' do
    profile = Profile.new(name: 'Name')

    profile.valid?

    expect(profile.errors[:name]).to_not include('não pode ser vazio')
  end

  it 'is invalid without name' do
    profile = Profile.new(name: '')

    profile.valid?

    expect(profile.errors[:name]).to include('não pode ser vazio')
  end

  ['11 1234-5678', '11 91234-5678'].each do |number|
    it "is valid with #{number} set to cell_phone" do
      profile = Profile.new(cell_phone: number)

      profile.valid?

      expect(profile.errors[:cell_phone]).to_not include('não é válido')
    end
  end

  ['1234-5678', '111234-5678'].each do |number|
    it "is invalid with #{number} set to cell_phone" do
      profile = create(:profile, :with_site_user)

      profile.update_attributes cell_phone: number

      expect(profile.errors[:cell_phone]).to include('não é válido')
    end
  end

  context "has donations_children" do
    it 'is invalid if type_recipient?' do
      child = build(:child)
      profile = build(:profile, profile_type: :recipient, donations_children: [child])

      profile.valid?

      expect(profile.errors[:base])
        .to include('Você precisa ser doadora para poder doar mensagens para outras crianças.')
    end
  end

  context "has donor children" do
    context "when profile_type change to donor" do
      it 'has to remove donor children' do
        donor_profile = create(:profile, profile_type: :donor)
        child = create(:child, :with_profile, donor: donor_profile)
        profile = child.profile

        profile.reload
        profile.profile_type = :donor
        profile.save

        expect(profile.children.last.donor).to be nil
      end
    end
    context "when is authorize_to_receive_sms" do
      it 'has to remove donor children' do
        donor_profile = create(:profile, profile_type: :donor)
        child = create(:child, :with_profile, donor: donor_profile)
        profile = child.profile

        profile.reload
        profile.authorize_receive_sms!

        expect(profile.children.last.donor).to be nil
      end
    end
  end
  context "is authorize_to_receive_sms" do
    context "when is unauthorize_receive_sms and not has device_registrations" do
      it "should return the profile_type to recipient" do
        profile = create(:profile, profile_type: :possible_donor, authorized_receive_sms: true)
        child = create(:child, profile: profile)

        profile.unauthorize_receive_sms!

        expect(profile.recipient?).to be true

      end
    end
  end
end
