module Devise
  class CustomFailure < Devise::FailureApp
    def redirect_url
      root_path
    end

    def respond
      if http_auth?
        http_auth
      else
        begin
          redirect
        rescue
          redirect_to new_user_session_path
        end
      end
    end
  end
end
