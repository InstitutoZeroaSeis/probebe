require 'rails_helper'

FactoryGirl.factories.map(&:name).each do |factory_name|
  next if factory_name == :device_registration_hash
  describe "The #{factory_name} factory" do
    it 'is valid' do
      expect(build_stubbed(factory_name)).to be_valid
    end
  end
end
