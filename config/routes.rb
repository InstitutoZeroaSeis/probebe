Rails.application.routes.draw do
  mount_carnival_at 'admin'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
    get 'sign_out', to: 'devise/sessions#destroy'
  end

  root to: 'home#index'

  namespace :admin do
    resources :users
    resources :messages
    resources :categories
  end
  
end
