Rails.application.routes.draw do

  root to: 'devices#index'

  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations',
        passwords: 'users/passwords'
      }

  get 'terms', to: 'static_pages#terms'
  get 'help', to: 'static_pages#help'

  resources :templates
  resources :devices do
    member do
      post :connect
      post :disconnect
    end
  end
end
