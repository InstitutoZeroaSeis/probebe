Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: 'profiles#show'

  resource :profile, except: :index
  resource :timeline, only: :show
  resources :message_deliveries, only: :create

  mount_carnival_at 'admin'
  namespace :admin do
    resources :authorial_articles
    resources :categories
    resources :journalistic_articles
    resources :messages
    resources :tags
    resources :users
    post 'users/:id/impersonate' => 'users#impersonate', as: :impersonate_user
    get 'users/:id/stop_impersonating' => 'users#stop_impersonating', as: :stop_impersonating
  end

end
