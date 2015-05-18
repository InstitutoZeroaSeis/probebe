require 'sidekiq/web'

Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root to: 'home#index'

  match ':status', to: 'errors#show', constraints: { status: /\d{3}/ }, via: [:get, :post]
  resource :profile, except: :index
  resources :timelines, only: :show
  get 'timelines/:id/monthly/:date' => 'timelines#monthly', as: :timeline_monthly
  constraints(id: /\d+/) do
    resources(:posts, only: [:show, :index]) do
      collection do
        scope :categories do
          get ':category_id', to: 'posts#index', as: :categories
        end
      end
      get :raw, on: :member
    end
  end
  get 'posts/page/:page_id' => 'posts#index', as: :paged_posts
  resources(:tags, param: :name) { resources :posts, only: :index }

  namespace :api do
    resources :credentials, only: :create
    resources :device_registrations, only: [:create, :show, :destroy], id: /[^\/]+/, param: :platform_code
    resources :messages, only: :show
    resources :children, only: :index
    post 'd3d4b74ea38c163c820cd84b25f5/a8eecbf2d604ff6769fd64f1a491' => 'message_deliveries#create'
  end

  mount_carnival_at 'admin'
  namespace :admin do
    authenticate :user, ->(u) { u.admin? }  do
      mount Sidekiq::Web => '/sidekiq'
    end
    resources :activity_logs, only: [:index, :show]
    resources :admin_site_users
    resources :authorial_articles
    resources :categories
    resources :journalistic_articles
    resources :messages
    resources :message_deliveries, only: :index
    resources :profiles
    resources :site_users do
      get :authorize_receive_sms, on: :member
      get :unauthorize_receive_sms, on: :member
    end
    resources :tags
    get 'authorial_articles/:id/create_journalistic_article' => 'authorial_articles#create_journalistic_article', as: :create_journalistic_article
    get 'journalistic_articles/:id/show_activity_log' => 'journalistic_articles#show_activity_log'
    get 'site_users/:id/stop_impersonating' => 'site_users#stop_impersonating', as: :stop_impersonating
    get 'admin_site_users/:id/edit_profile' => 'admin_site_users#edit_profile', as: :edit_profile
    post 'site_users/:id/impersonate' => 'site_users#impersonate', as: :impersonate_user
  end
end
