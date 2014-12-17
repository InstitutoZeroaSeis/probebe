class ProBebeConfig

protected

  APP_CONFIG = YAML.load_file(Rails.root.join('config','application.yml'))[Rails.env]

public

  def self.deliver_sms?
    APP_CONFIG['message_delivery']['deliver_sms']
  end

  def self.wsdl_url
    APP_CONFIG['message_delivery']['wsdl_url']
  end

  def self.wsdl_end_point
    APP_CONFIG['message_delivery']['wsdl_end_point']
  end

  def self.wsdl_name_space
    APP_CONFIG['message_delivery']['wsdl_name_space']
  end

end
