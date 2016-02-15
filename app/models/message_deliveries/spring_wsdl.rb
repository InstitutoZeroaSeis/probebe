module MessageDeliveries
  class SpringWsdl
    require 'savon'

    def self.send_message(cell_phone, message, messageId)
      client = Savon.client(wsdl: ProBebeConfig.wsdl_url, endpoint: ProBebeConfig.wsdl_end_point ,namespace: ProBebeConfig.wsdl_name_space)
      result = client.call(:send, soap_action: false, message: { user: ProBebeConfig.spring_user, password: ProBebeConfig.spring_password, phone: cell_phone, messageText: message, clientsMessageId: messageId})
      Rails.logger.debug result
    rescue Savon::SOAPFault => e
      raise unless e.message.include? "SMS gateway blacklist"
      false
    end
  end
end
