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
      profile = Profile.new(cell_phone: number)

      profile.valid?

      expect(profile.errors[:cell_phone]).to include('não é válido')
    end
  end
end
