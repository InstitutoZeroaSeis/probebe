module MessageDeliveries
  class ZenviaSmsSender
    def self.send phone, message
      begin
        phone = "55#{phone}"
        Rails.logger.debug "Sending SMS #{phone}"
        account = ENV['ZENVIA_ACCOUNT']
        code = ENV['ZENVIA_PASSWORD']
        params = {
          account: "#{account}",
          code: "#{code}",
          dispatch: 'send',
          from: 'ProBebe',
          to: phone,
          msg: message
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
      parameters = URI.escape(params.collect{|k,v| "#{k}=#{v}"}.join('&'))
      make_req api_url, parameters
    end

  private
  def self.make_req api_url, parameters
      data = URI.parse("#{api_url}?#{parameters}").read
      response =  Rack::Utils.parse_nested_query(data)
    end
  end
end
