require 'sidekiq/web'

Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root to: 'home#index'

  match ':status', to: 'errors#show', constraints: { status: /\d{3}/ }, via: [:get, :post]
  resource :profile, except: :index do
    get :active, on: :member
    get :disable, on: :member
  end
  resources :timelines, only: :show
  get 'timelines/:id/monthly/:date' => 'timelines#monthly', as: :timeline_monthly
  constraints(id: /\d+/) do
    resources(:posts, only: [:show, :index])
  end
  resources(:articles, only: [:show, :index]) do
    collection do
      scope :categories do
        get ':category_id', to: 'articles#index', as: :categories
      end
    end
    get :raw, on: :member
  end

  resources :partners, only: :show
  get 'articles/page/:page_id' => 'articles#index', as: :paged_articles
  resources(:tags, param: :name, only: []) { resources :articles, only: :index }
  resources(:categories) { resources :articles, only: :index }
  get :colaborators, to: 'static_pages#colaborators'
  resources :authors, only: :show
  resources :pages, only: :show

  namespace :api do
    resources :credentials, only: :create
    post 'credentials/update_social_network_id' => 'credentials#update_social_network_id'
    resources :device_registrations, only: [:create, :show, :destroy], id: /[^\/]+/, param: :platform_code
    resources :messages, only: :show
    resources :profiles, only: [:index]
    get 'active_profile' => 'profiles#active'
    get 'disable_profile' => 'profiles#disable'
    post 'profiles/max_recipient_children' => 'profiles#update_max_recipient_children'
    post "profiles" => 'profiles#update'
    resources :donated_messages, only: [:index]
    post 'donated_messages/mark_as_sent' => 'donated_messages#mark_as_sent'
    resources :children, only: :index
    post 'd3d4b74ea38c163c820cd84b25f5/a8eecbf2d604ff6769fd64f1a492' => 'message_deliveries#create'
    devise_scope :user do
      post "/users" => 'users#create'
      post '/users/reset_password' => 'passwords#create'
    end
    get 'birthday_cards/show' => 'birthday_cards#show'
    get 'only_new_messages' => 'messages#only_new'
    resources :categories, only: [:index]
  end

  mount_carnival_at 'admin'
  namespace :admin do
    authenticate :user, ->(u) { u.admin? }  do
      mount Sidekiq::Web => '/sidekiq'
    end
    resources :activity_logs, only: [:index, :show]
    resources :admin_site_users
    resources :articles
    resources :posts
    resources :authors
    resources :categories
    resources :messages
    resources :message_deliveries, only: :index
    resources :profiles
    resources :site_banners
    resources :site_headers
    resources :site_landing_pages
    resources :site_mobile_images
    resources :partners
    resources :site_users do
      get :authorize_receive_sms, on: :member
      get :unauthorize_receive_sms, on: :member
      get :active_profile, on: :member
      get :disable_profile, on: :member
    end
    resources :tags
    resources :birthday_cards
    resources :pages
    resources :menus
    resources :manager_message_deliveries, only: :index
    get 'articles/:id/show_activity_log' => 'articles#show_activity_log'
    get 'site_users/:id/stop_impersonating' => 'site_users#stop_impersonating', as: :stop_impersonating
    get 'admin_site_users/:id/edit_profile' => 'admin_site_users#edit_profile', as: :edit_profile
    get 'site_users/:id/impersonate' => 'site_users#impersonate', as: :impersonate_user

    get 'gallery_images' => 'gallery_images#index'

    post 'new_image' => 'cms_images#create'
  end
end
