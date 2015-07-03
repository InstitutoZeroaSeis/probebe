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
  resources(:tags, param: :name, only: []) { resources :posts, only: :index }
  resources(:categories) { resources :posts, only: :index }
  get :about, to: 'static_pages#about'
  get :partners, to: 'static_pages#partners'
  get :what, to: 'static_pages#what'

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
    resources :articles
    resources :authors, only: [:new, :index, :edit, :update, :create, :show]
    resources :categories
    resources :messages
    resources :message_deliveries, only: :index
    resources :profiles
    resources :site_banners
    resources :site_users do
      get :authorize_receive_sms, on: :member
      get :unauthorize_receive_sms, on: :member
    end
    resources :tags
    get 'articles/:id/show_activity_log' => 'articles#show_activity_log'
    get 'site_users/:id/stop_impersonating' => 'site_users#stop_impersonating', as: :stop_impersonating
    get 'admin_site_users/:id/edit_profile' => 'admin_site_users#edit_profile', as: :edit_profile
    post 'site_users/:id/impersonate' => 'site_users#impersonate', as: :impersonate_user

    get 'gallery_images' => 'gallery_images#index'

    post 'new_image' => 'cms_images#create'
  end
end
