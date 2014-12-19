module MessageDeliveries
  class SpringWsdl
    require 'savon'

    def self.send_message(cell_phone, message)
      #source_id numero curto
      #clientMessagesId
      client = Savon.client(wsdl: ProBebeConfig.wsdl_url, endpoint: ProBebeConfig.wsdl_end_point ,namespace: ProBebeConfig.wsdl_name_space )
      result = client.call(:send, soap_action: false, message: { user: "sw_piloto2", password: "swwspiloto2", phone: cell_phone, messageText: message })
      Rails.logger.debug result
    rescue Savon::SOAPFault => e
      raise unless e.message.include? "SMS gateway blacklist"
      false
    end
  end
end
