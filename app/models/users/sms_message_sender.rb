class Users::SmsMessageSender
  def self.send_completed_profile_msg(user)
    user.reload
    profile = user.profile
    self.authorize_receive_sms_by_engine(user)
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

  def self.send_disable_receive_msg(user)
    user.reload
    message = I18n.t('profile_messages.disable_receive_msg')
    MessageDeliveries::ZenviaSmsSender.send(
                           user.profile.cell_phone_numbers,
                           message )
  end

  def self.send_active_receive_msg(user)
    user.reload
    message = I18n.t('profile_messages.active_receive_msg')
    MessageDeliveries::ZenviaSmsSender.send(
                           user.profile.cell_phone_numbers,
                           message )
  end

  def self.authorize_receive_sms_by_engine(user)
    user.profile.authorize_receive_sms! if Engine.first.authorize_receive_sms?
  end


end
