module MessageDeliveries
  class ZenviaSmsSender
    def self.send phone, message
      begin
        phone = "55#{phone}"
        Rails.logger.info "Sending SMS #{phone}"
        message = message[0..150] if message.size > 150
        params = {
          sendSmsRequest:{
            from: 'ProBebe',
            to: phone,
            msg: message
          }
        }
        resp = send_request params
        Rails.logger.debug "Sending SMS #{phone} - Response #{resp}"
        return resp
      rescue => e
        Rails.logger.error "A error occurs on send SMS #{phone}, #{e}"
      end
    end

    def self.send_request params
      api_url = ProBebe::Application.config.zenvia_url
      account = ENV['ZENVIA_ACCOUNT']
      code = ENV['ZENVIA_PASSWORD']
      resp = RestClient.post "https://#{account}:#{code}@#{api_url}", params.to_json, :content_type => :json, :accept => :json
      JSON.parse resp
    end
  end
end
