require 'rails_helper'

RSpec.describe CellPhone, :type => :model do
  describe CellPhone do
    context "number with 9 digits" do
      subject { build(:cell_phone, number: "99999-9999") }
      it { is_expected.to be_valid }
    end

    context "number with 8 digits" do
      subject { build(:cell_phone, number: "9999-9999") }
      it { is_expected.to be_valid }
    end

    context "number with 5 digits" do
      subject { build(:cell_phone, number: "999-9999") }
      it { is_expected.to be_invalid }
    end

    context "area_code with 2 digits" do
      subject { build(:cell_phone, area_code: "91") }
      it { is_expected.to be_valid }
    end

    context "area_code lesser than 2 digits" do
      subject { build(:cell_phone, area_code: "1") }
      it { is_expected.to be_invalid }
    end
  end
end
