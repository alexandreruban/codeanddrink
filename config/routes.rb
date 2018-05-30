Rails.application.routes.draw do
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
      resources :rounds, only: [:index] do
        member do
          patch :start
          patch :stop
          patch :update_number_of_winners
        end
      end
    end
  end
end
