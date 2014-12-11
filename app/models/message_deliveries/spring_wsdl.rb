module MessageDeliveries
  class SpringWsdl
    require 'savon'

    # WSDL_URL = "http://webservice.springvas.com.br:50983/BasicSourceMT?WSDL"
    WSDL_URL = "http://probebe.vzr.com.br:3020/BasicSourceMT?wsdl"
    END_POINT = "http://probebe.vzr.com.br:3020/BasicSourceMT"
    NAMESPACE = "http://basic.webservice.gateway.springwireless.com/"

    def self.send_message(cell_phone, message)
      #source_id numero curto
      #clientMessagesId
      client = Savon.client(wsdl: WSDL_URL, endpoint: END_POINT ,namespace: NAMESPACE )
      client.call(:send, soap_action: false, message: { user: "sw_piloto2", password: "swwspiloto2", phone: cell_phone, messageText: message })
    rescue Savon::SOAPFault => e
      raise unless e.message.include? "SMS gateway blacklist"
      false
    end
  end
end
