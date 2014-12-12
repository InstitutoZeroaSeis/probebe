Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: 'posts#index'

  resource :profile, except: :index
  resource :timeline, only: :show
  resources :message_deliveries, only: :create
  resources(:posts, only: [:show, :index])
  get 'posts/page/:page_id' => 'posts#index', as: :paged_posts
  resources(:tags) { resources :posts, only: :index }
  resources(:categories) { resources :posts, only: :index }
  resources :credentials, only: :create
  resources :device_registrations, only: [:create, :show, :destroy]

  namespace :api do
    resources :messages, only: :show
    resources :children, only: :index
  end

  mount_carnival_at 'admin'
  namespace :admin do
    resources :activity_logs, only: [:index, :show]
    resources :admin_site_users
    resources :authorial_articles
    resources :categories
    resources :journalistic_articles
    resources :messages
    resources :message_deliveries
    resources :site_users
    resources :tags
    get 'authorial_articles/:id/create_journalistic_article' => 'authorial_articles#create_journalistic_article', as: :create_journalistic_article
    get 'journalistic_articles/:id/show_activity_log' => 'journalistic_articles#show_activity_log'
    get 'site_users/:id/stop_impersonating' => 'site_users#stop_impersonating', as: :stop_impersonating
    post 'site_users/:id/impersonate' => 'site_users#impersonate', as: :impersonate_user
  end

end
