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
    [:cell_phone, :home_phone, :business_phone].each do |phone_type|
      it "is valid with #{number} set to #{phone_type}" do
        profile = Profile.new(
          phone_type => number
        )

        profile.valid?

        expect(profile.errors[phone_type]).to_not include('não é válido')
      end
    end
  end

  ['1234-5678', '111234-5678'].each do |number|
    [:cell_phone, :home_phone, :business_phone].each do |phone_type|
      it "is invalid with #{number} set to #{phone_type}" do
        profile = Profile.new(
          phone_type => number
        )

        profile.valid?

        expect(profile.errors[phone_type]).to include('não é válido')
      end
    end
  end
end
