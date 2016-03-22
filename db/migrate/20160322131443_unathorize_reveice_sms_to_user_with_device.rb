class UnathorizeReveiceSmsToUserWithDevice < ActiveRecord::Migration
  def change
     User.completed_profile
     .where('profiles.authorized_receive_sms = ?', true)
     .where("device_registrations.profile_id IS NOT NULL").each do |user|
        user.profile.unauthorize_receive_sms!
      end
  end
end
