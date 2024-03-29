# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :users do
    get '/attendances',         as: 'attendance', to: 'attendances#edit'
    resources :profiles,        only: %i[edit update destroy]
  end
  namespace :hosts do
    resources :reservations,    only: %i[edit update]
  end
  namespace :planners do
    resources :reservations,    only: %i[edit update new create destroy]
  end
  namespace :managers do
    resources :users,           only: %i[edit update new create index destroy]
    resources :events,          only: %i[edit update new create index destroy]
    resources :reservations,    only: %i[edit update new create destroy]
    resources :repeat_bookings, only: %i[edit update new create index destroy]
  end

  namespace :participants do
    get '/home',                as: 'home',         to: 'home#index'
    get '/sessions/:token',     as: 'session_auth', to: 'sessions#auth'
    get '/attendances',         as: 'attendance',   to: 'attendances#edit'
    resources :sessions,        only: [:destroy]
    resources :magic_links,     only: %i[new create]
    resources :profiles,        only: %i[edit update destroy]
  end

  get  'tokens/:auth', as: :auth_tokens,   to: 'tokens#auth'
  get  'tokens',       as: :new_tokens,    to: 'tokens#new'
  post 'tokens',       as: :create_tokens, to: 'tokens#create'

  devise_for :users

  # get 'landing/index'
  get '/landing', to: 'landing#index',  as: :landing

  # ugly, but works as auto-redirect upon login
  # https://stackoverflow.com/questions/4753871/how-can-i-redirect-a-users-home-root-path-based-on-their-role-using-devise
  root to: 'landing#index',             as: :landing_root, constraints: ->(request) { !request.env['warden'].user }
  # root to: 'participants/home#index',   as: :participant_root, constraints: lambda { |request| !request.env['warden'].user && request.env['warden'].participant }
  root to: 'viewers/home#index',        as: :user_root,    constraints: lambda { |request|
                                                                          request.env['warden'].user.access_role.blank?
                                                                        }
  root to: 'hosts/home#index', as: :host_root, constraints: lambda { |request|
                                                              request.env['warden'].user.access_role == 'host'
                                                            }
  root to: 'viewers/home#index', as: :viewer_root, constraints: lambda { |request|
                                                                  request.env['warden'].user.access_role == 'viewer'
                                                                }
  root to: 'planners/home#index', as: :planner_root, constraints: lambda { |request|
                                                                    request.env['warden'].user.access_role == 'planner'
                                                                  }
  root to: 'managers/home#index', as: :manager_root, constraints: lambda { |request|
                                                                    request.env['warden'].user.access_role == 'manager'
                                                                  }
  # root to: 'hosts/home#index',          as: :umdze_root,   constraints: lambda { |request|  request.env['warden'].user.access_role == 'umdze' }
  # root to: 'viewers/home#index',        as: :member_root,  constraints: lambda { |request|  request.env['warden'].user.access_role == 'member' }
  # root to: 'managers/home#index',       as: :trustee_root, constraints: lambda { |request|  request.env['warden'].user.access_role == 'trustee' }
  root to: 'landing#index'

  # These cause csfr error!!!
  ###########################
  # authenticated :user, ->(user) { user.access_role == 'manager' } do
  #   root to: 'managers/home#index', as: :manager_root
  # end
  # authenticated :user, ->(user) { user.access_role == 'host' } do
  #   root to: 'hosts/home#index', as: :host_root
  # end
  # authenticated :user, ->(user) { user.access_role == 'viewer' } do
  #   root to: 'viewers/home#index', as: :viewer_root
  # end

  # This is the safe way to have multiple user routes by types
  # ROUTES ONLY AVAILABLE IF AUTHENTICATED:
  # https://github.com/heartcombo/devise/wiki/How-To:-Define-resource-actions-that-require-authentication-using-routes.rb
  ##################
  # authenticated :user do
  #   namespace :users do
  #     resources :profiles, only: [:edit, :update, :destroy]
  #   end
  #   namespace :hosts do
  #     resources :reservations, only: [:edit, :update]
  #   end
  #   namespace :managers do
  #     resources :users,        only: [:edit, :update, :new, :create, :index, :destroy]
  #     resources :events,       only: [:edit, :update, :new, :create, :index, :destroy]
  #     resources :reservations, only: [:edit, :update, :new, :create, :destroy]
  #   end
  # end
end
