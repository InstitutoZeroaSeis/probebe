module Features
  module OAuthHelper
    def sign_in_through_oauth
      visit root_path
      click_on "Logar com Google Oauth2"
    end
  end
end
