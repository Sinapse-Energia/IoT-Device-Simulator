require 'sidekiq/web'

Rails.application.routes.draw do

  root to: 'devices#index'
  mount ActionCable.server => '/cable'

  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations',
        passwords: 'users/passwords'
      }

  get 'terms', to: 'static_pages#terms'
  get 'help', to: 'static_pages#help'

  resources :templates do
    member do
      get :get_template
    end
  end
  resources :devices do
    member do
      get :get_device
      get :get_messages
      post :connect
      post :disconnect
    end
  end
end
