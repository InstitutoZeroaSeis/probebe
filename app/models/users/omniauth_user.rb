module Users
  class OmniauthUser

    def initialize(provider_info)
      @provider_info = provider_info
      @first_name = provider_info.first_name
      @last_name = provider_info.last_name
      @email = provider_info.email
    end

    def find_or_create
      User.find_by(email: @email) ||
        User.create!(first_name: @first_name, last_name: @last_name, email: @email)
    end

  end
end
