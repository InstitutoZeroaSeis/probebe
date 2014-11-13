Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: 'posts#index'

  resource :profile, except: :index
  resource :timeline, only: :show
  resources :message_deliveries, only: :create
  resources :posts, only: [:show, :index]

  mount_carnival_at 'admin'
  namespace :admin do
    resources :authorial_articles
    resources :categories
    resources :journalistic_articles
    resources :messages
    resources :users
    resources :tags
    get 'authorial_articles/:id/create_journalistic_article' => 'authorial_articles#create_journalistic_article', as: :create_journalistic_article
    get 'users/:id/stop_impersonating' => 'users#stop_impersonating', as: :stop_impersonating
    post 'users/:id/impersonate' => 'users#impersonate', as: :impersonate_user
  end

end
