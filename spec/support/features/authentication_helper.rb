module Features
  module AuthenticationHelper
    def sign_in(email, password)
      visit root_path
      click_on I18n.t('views.application.sign_in')
      fill_in "Email", with: email
      fill_in "Senha", with: password
      click_on "Entrar"
    end

    def sign_in_through_oauth
      visit root_path
      click_on I18n.t('views.application.sign_in')
      click_on "Logar com Google Oauth2"
    end

    def sign_out
      click_on 'Sair'
    end
  end
end
