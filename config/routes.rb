Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :game_masters

  resources :games, only: [:show] do
    resources :players, only: [:new, :create, :create, :destroy]
  end

  resources :rounds, only: [] do
    resources :attempts, only: [:create]
  end

  namespace :game_masters do
    resources :games do
      resources :rounds, only: [:index, :update]
    end
  end
end
