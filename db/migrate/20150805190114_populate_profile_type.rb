class PopulateProfileType < ActiveRecord::Migration
  def up
    Profile.ios.each do |profile|
      profile.update_attributes profile_type: :possible_donor
    end
    Profile.android.each do |profile|
      profile.update_attributes profile_type: :possible_donor
    end
  end

  def down

  end
end
