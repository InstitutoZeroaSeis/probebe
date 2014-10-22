describe Profiles::ProfileCreator do
  context "with valid profile data" do
    let (:profile_creator_data) { create(:profile_creator_data) }
    subject { Profiles::ProfileCreator.new(profile_creator_data) }

    it "should create a user profile" do
      expect(subject.save).to eq(true)
    end
  end

  context "with invalid profile data" do
    subject { Profiles::ProfileCreator.new({}) }
    it "should not create a user profile" do
      expect(subject.save).to eq(false)
    end
  end
end
