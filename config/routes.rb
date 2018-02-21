Rails.application.routes.draw do

  root to: 'devices#index'

  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations',
        passwords: 'users/passwords'
      }

  get 'terms', to: 'static_pages#terms'
  get 'help', to: 'static_pages#help'

  get 'templates', to: 'templates#index'
  get 'templates/new', to: 'templates#new'
  get 'devices/new', to: 'devices#new'
end
