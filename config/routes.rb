Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
    get 'sign_out', to: 'devise/sessions#destroy'
  end

  mount_carnival_at '/'

  root to: 'home#index'

  resources :messages
end
