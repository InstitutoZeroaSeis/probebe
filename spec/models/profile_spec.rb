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
      profile = build(:profile, profile_type: :type_recipient, donations_children: [child])

      profile.valid?

      expect(profile.errors[:base])
        .to include('Você precisa ser doadora para poder doar mensagens para outras crianças.')
    end
  end

  context "has donor children" do
    context "when profile_type change to type_donor" do
      it 'has to remove donor children' do
        donor_profile = create(:profile, profile_type: :type_donor)
        child = create(:child, :with_profile, donor: donor_profile)
        profile = child.profile

        profile.reload
        profile.profile_type = :type_donor
        profile.save

        expect(profile.children.last.donor).to be nil
      end
    end
  end
end
