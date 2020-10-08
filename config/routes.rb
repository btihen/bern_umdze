Rails.application.routes.draw do

  # namespace :trustees do
  #   resources :reservations, except: [:index]
  #   get 'home/index', as: :home
  #   # resource  :home,       only: [:index]
  # end
  # get '/trustees', to: 'trustees/home#index', as: :trustees

  # namespace :umdzes do
  #   resources :reservations, only: [:edit, :update]
  #   get 'home/index', as: :home
  #   # resource  :home,       only: [:index]
  # end
  # get '/umdzes', to: 'umdzes/home#index', as: :umdzes

  # namespace :members do
  #   # get 'home/index', as: :home
  #   # resource  :home,       only: [:index]
  # end
  # get '/members', to: 'members/home#index', as: :members

  # get '/home', to: 'members/home#index',  constraints: lambda { |request| !request.env['warden'].user }
  # get '/home', to: 'members/home#index',  constraints: lambda { |request|  request.env['warden'].user.access_role.blank? }
  # resources :reservations, only: [:edit, :update], constraints: lambda { |request|  request.env['warden'].user.access_role == :umdze }

  # # https://stackoverflow.com/questions/4753871/how-can-i-redirect-a-users-home-root-path-based-on-their-role-using-devise
  # get '/home', to: 'members/home#index',  constraints: lambda { |request| !request.env['warden'].user }
  # get '/home', to: 'members/home#index',  constraints: lambda { |request|  request.env['warden'].user.access_role.blank? }
  # get '/home', to: 'umdzes/home#index',   constraints: lambda { |request|  request.env['warden'].user.access_role == :umdze }
  # get '/home', to: 'members/home#index',  constraints: lambda { |request|  request.env['warden'].user.access_role == :member }
  # get '/home', to: 'trustees/home#index', constraints: lambda { |request|  request.env['warden'].user.access_role == :trustee }
  # or
  # https://bjedrocha.com/rails/2015/03/18/role-based-routing-in-rails/
  # constraints RoleRouteConstraint.new { |user| user.has_role? :trustee } do
  #   get '/home', to: 'trustees/home#index'
  # end
  # constraints RoleRouteConstraint.new { |user| user.has_role? :umdze } do
  #   get '/home', to: 'umdzes/home#index'
  # end
  # constraints RoleRouteConstraint.new { |user| user.has_role? :member } do
  #   get '/home', to: 'members/home#index'
  # end

  # get 'landing/index'
  # https://stackoverflow.com/questions/4753871/how-can-i-redirect-a-users-home-root-path-based-on-their-role-using-devise
  get '/landing', to: 'landing#index', as: :landing

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
  # ONLY AVAILABLE IF AUTHENTICATED:
  # https://github.com/heartcombo/devise/wiki/How-To:-Define-resource-actions-that-require-authentication-using-routes.rb
  ##################
  authenticated :user do

    namespace :users do
      resources :profiles, only: [:edit, :update, :destroy]
    end
    namespace :umdzes do
      resources :reservations, only: [:edit, :update]
    end
    namespace :planners do
      resources :reservations, only: [:edit, :update, :new, :create, :destroy]
    end
    namespace :trustees do
      resources :users,        only: [:edit, :update, :new, :create, :index, :destroy]
      resources :events,       only: [:edit, :update, :new, :create, :index, :destroy]
      resources :reservations, only: [:edit, :update, :new, :create, :destroy]
    end

    # ugly, but works as auto-redirect upon login
    root to: 'landing#index',       as: :landing_root, constraints: lambda { |request| !request.env['warden'].user }
    root to: 'members/home#index',  as: :user_root,    constraints: lambda { |request|  request.env['warden'].user.access_role.blank? }
    root to: 'umdzes/home#index',   as: :umdze_root,   constraints: lambda { |request|  request.env['warden'].user.access_role == 'umdze' }
    root to: 'members/home#index',  as: :member_root,  constraints: lambda { |request|  request.env['warden'].user.access_role == 'member' }
    root to: 'planners/home#index', as: :planner_root, constraints: lambda { |request|  request.env['warden'].user.access_role == 'planner' }
    root to: 'trustees/home#index', as: :trustee_root, constraints: lambda { |request|  request.env['warden'].user.access_role == 'trustee' }
  end

  # get '/home', to: 'landing#index'
  root to: "landing#index"

end
