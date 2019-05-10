Rails.application.routes.draw do

  root 'events#index'

  devise_for :users

  resources :users, only: [:show] do
    resources :avatars, only: [:create]
  end

  resources :events

end
