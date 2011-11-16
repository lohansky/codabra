CodabraWorld::Application.routes.draw do

  root :to => 'home#index'

  match '/signup',  to: 'codabras#new', as: :signup
  match '/signin',  to: 'sessions#new', as: :signin
  match '/signout', to: 'sessions#destroy', as: :signout, method: :delete

  resource :session, only: [:new, :create, :destroy]
  resources :passwords, only: [:new, :create, :edit, :update]

  resources :codabras

  resources :battles do
    put 'fight', on: :member
    get 'log', on: :member
  end

  match '/arena', to: 'battles#index', as: :arena

  resources :programs do
    get 'test', on: :member
  end

  match ':name', to: 'codabras#show', as: :profile
  match ':name/edit', to: 'codabras#edit', as: :edit_profile
end
