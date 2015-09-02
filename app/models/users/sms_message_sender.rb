class Users::SmsMessageSender
  def self.send_completed_profile_msg(user)
    user.reload
    profile = user.profile
    return if profile.profile_completed_message_sent?
    return if profile.cell_phone.nil?
    return if profile.children.empty?
    message = I18n.t('profile_messages.completed_without_smartphone')
    if profile.ios? || profile.android?
      message = I18n.t('profile_messages.completed_with_smartphone')
    end
    profile.profile_completed_message_sent!
    MessageDeliveries::ZenviaSmsSender.send(
                           profile.cell_phone_numbers,
                           message )
  end


  def self.send_authorize_receive_sms_msg(user)
    user.reload
    profile = user.profile
    return if profile.allow_sms_message_sent?
    message = I18n.t('profile_messages.authorized_receive_sms')
    profile.allow_sms_message_sent!
    MessageDeliveries::ZenviaSmsSender.send(
                           profile.cell_phone_numbers,
                           message )
  end

end