Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    get 'sign_out', to: 'devise/sessions#destroy'
  end
  root to: 'home#index'

  resources :personal_profiles

  mount_carnival_at 'admin'
  namespace :admin do
    resources :users
    resources :messages
    resources :categories
  end

end
