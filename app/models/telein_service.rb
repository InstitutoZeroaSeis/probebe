class TeleinService
  def self.mobile_phone? number
    api_url = ProBebe::Application.config.telein_url
    api_url = "#{api_url}?chave=#{ENV['TELEIN_KEY']}&numero=#{number}"
    resp = RestClient.get api_url
    resp = JSON.parse resp
    return true if resp['operadora'].start_with? '553'
    false
  end

end
