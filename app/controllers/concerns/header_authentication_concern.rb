module HeaderAuthenticationConcern
  extend ActiveSupport::Concern

  included do
    before_action :check_authentication_headers
    protect_from_forgery with: :null_session
  end

  def check_authentication_headers
    email = request.headers['X-User-Email']
    password = request.headers['X-User-Password']
    user = User.find_by(email: email)
    if user.try(:valid_password?, password)
      sign_out
      sign_in user
      impersonate_user user
    else
      head :unauthorized
    end
  end
end
