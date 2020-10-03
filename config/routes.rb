Rails.application.routes.draw do
  # namespace :manager do
  #   get 'home/index'
  # end
  # namespace :umdze do
  #   get 'home/index'
  # end
  # namespace :member do
  #   get 'home/index'
  # end
  # namespace :user do
  #   get 'home/index'
  # end
  get '/home', to: 'home#index', as: :home
  # get 'home/index'

  devise_for :users
  authenticated :user do
    root to: 'home#index', as: :user_root
  end

  # get 'landing/index'
  get '/landing', to: 'landing#index', as: :landing

  root to: "landing#index"
end
