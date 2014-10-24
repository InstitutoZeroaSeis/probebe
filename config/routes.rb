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
    post 'users/:id/impersonate' => 'users#impersonate', as: :impersonate_user
    get 'users/:id/stop_impersonating' => 'users#stop_impersonating', as: :stop_impersonating
  end

end
