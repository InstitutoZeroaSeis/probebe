module Controllers
  module ApiAuthenticationHelper
    def authenticate_through_headers(email, password)
      @request.headers["X-User-Email"] = email
      @request.headers["X-User-Password"] = password
    end
  end
end
