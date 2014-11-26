module HeaderAuthenticationConcern
  extend ActiveSupport::Concern

  included do
    before_filter :check_authentication_headers
  end

  def check_authentication_headers
    unless user_signed_in?
      email = request.headers['X-User-Email']
      password = request.headers['X-User-Password']
      user = User.find_by(email: email)
      if user and user.valid_password?(password)
        sign_in user
      end
    end
  end

end
