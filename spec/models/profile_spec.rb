require 'rails_helper'

RSpec.describe Profile, type: :model do
  it 'is valid with first name' do
    profile = Profile.new(first_name: 'Name')

    profile.valid?

    expect(profile.errors[:first_name]).to_not include('não pode ser vazio')
  end

  it 'is valid with last name' do
    profile = Profile.new(last_name: 'Name')

    profile.valid?

    expect(profile.errors[:last_name]).to_not include('não pode ser vazio')
  end

  it 'is invalid without first name' do
    profile = Profile.new(first_name: '')

    profile.valid?

    expect(profile.errors[:first_name]).to include('não pode ser vazio')
  end

  it 'is invalid without last name' do
    profile = Profile.new(last_name: '')

    profile.valid?

    expect(profile.errors[:last_name]).to include('não pode ser vazio')
  end

  it 'is expected to set the name attribute when creating' do
    profile = build_stubbed(:profile)

    profile.run_callbacks(:save)

    expect(profile.name).to eq("#{profile.first_name} #{profile.last_name}")
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
