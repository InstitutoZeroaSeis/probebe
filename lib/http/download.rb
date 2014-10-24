class Http::Download
  LOGGER = Logger.new(STDOUT)
  def self.log(message)
    LOGGER.debug message
  end

  def self.download(path)
    current_path = path
    response_body = nil
    log("Downloading file #{path}")
    binding.pry
    1.upto(5) do |n|
      res = Net::HTTP.get_response(URI(current_path))
      log("-- Current path #{current_path}")
      log("-- Response")
      log("--- Status #{res.code}")
      if res.code == '200'
        response_body = res.body
        break
      elsif res.code == '301' || res.code == '302'
        current_path = res.header['Location']
      end
    end
    StringIO.new response_body
  end
end
