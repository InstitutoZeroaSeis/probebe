class SpringWsdl
  require 'savon'

  # WSDL_URL = "http://webservice.springvas.com.br:50983/BasicSourceMT?WSDL"
  WSDL_URL = "data/BasicSourceMT.xml"


  def self.send_message(cell_phone, message)
    client = Savon.client(wsdl: WSDL_URL, endpoint:"http://pro-bebe:3020/BasicSourceMT" ,namespace:"http://basic.webservice.gateway.springwireless.com/")
    cell_phone_number = cell_phone.to_s
    response = client.call(:send, soap_action: false, message: { user: "sw_piloto2", password: "swwspiloto2", phone: cell_phone_number, messageText: message_to_send })
    response.body
  end
end
