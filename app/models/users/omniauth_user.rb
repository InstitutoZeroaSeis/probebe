module Users
  class OmniauthUser

    def initialize(auth_info)
      @auth_info = auth_info
      @first_name = auth_info.first_name
      @last_name = auth_info.last_name
      @email = auth_info.email
    end

    def find_or_create
      User.find_by(email: @email) ||
        User.create!(first_name: @first_name, last_name: @last_name, email: @email)
    end

  end
end
