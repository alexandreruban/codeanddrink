Rails.application.routes.draw do

  mount ActionCable.server, at: '/cable'

  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  authenticate :game_master do
    mount Sidekiq::Web => '/sidekiq'
  end

  root to: 'pages#home'
  devise_for :game_masters

  resources :games, only: [:show] do
    resources :players, only: [:new, :create, :show, :destroy]
  end

  resources :rounds, only: [] do
    resources :attempts, only: [:create]
  end

  namespace :game_master do
    resources :games do
      resources :rounds, only: [:index, :edit, :update, :new, :create] do
        member do
          patch :start
          patch :stop
          patch :update_number_of_winners
        end
      end
    end
    resources :rounds, only: [:destroy]

  end
end
