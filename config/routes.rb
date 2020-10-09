Rails.application.routes.draw do

  namespace :users do
    resources :profiles, only: [:edit, :update, :destroy]
  end
  namespace :umdzes do
    resources :reservations, only: [:edit, :update]
  end
  namespace :trustees do
    resources :users,        only: [:edit, :update, :new, :create, :index, :destroy]
    resources :events,       only: [:edit, :update, :new, :create, :index, :destroy]
    resources :reservations, only: [:edit, :update, :new, :create, :destroy]
  end

  devise_for :users
  # These cause csfr error!!!
  ###########################
  # authenticated :user, ->(user) { user.access_role == 'trustee' } do
  #   root to: 'trustees/home#index', as: :trustee_root
  # end
  # authenticated :user, ->(user) { user.access_role == 'umdze' } do
  #   root to: 'umdzes/home#index', as: :umdze_root
  # end
  # authenticated :user, ->(user) { user.access_role == 'member' } do
  #   root to: 'members/home#index', as: :member_root
  # end

  # This is the safe way to have multiple user routes by types
  # ROUTES ONLY AVAILABLE IF AUTHENTICATED:
  # https://github.com/heartcombo/devise/wiki/How-To:-Define-resource-actions-that-require-authentication-using-routes.rb
  ##################
  # authenticated :user do
  #   namespace :users do
  #     resources :profiles, only: [:edit, :update, :destroy]
  #   end
  #   namespace :umdzes do
  #     resources :reservations, only: [:edit, :update]
  #   end
  #   namespace :trustees do
  #     resources :users,        only: [:edit, :update, :new, :create, :index, :destroy]
  #     resources :events,       only: [:edit, :update, :new, :create, :index, :destroy]
  #     resources :reservations, only: [:edit, :update, :new, :create, :destroy]
  #   end
  # end

  # get 'landing/index'
  get '/landing', to: 'landing#index', as: :landing

  # ugly, but works as auto-redirect upon login
  # https://stackoverflow.com/questions/4753871/how-can-i-redirect-a-users-home-root-path-based-on-their-role-using-devise
  root to: 'landing#index',       as: :landing_root, constraints: lambda { |request| !request.env['warden'].user }
  root to: 'members/home#index',  as: :user_root,    constraints: lambda { |request|  request.env['warden'].user.access_role.blank? }
  root to: 'umdzes/home#index',   as: :umdze_root,   constraints: lambda { |request|  request.env['warden'].user.access_role == 'umdze' }
  root to: 'members/home#index',  as: :member_root,  constraints: lambda { |request|  request.env['warden'].user.access_role == 'member' }
  root to: 'trustees/home#index', as: :trustee_root, constraints: lambda { |request|  request.env['warden'].user.access_role == 'trustee' }
  root to: "landing#index"

end
