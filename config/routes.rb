Rails.application.routes.draw do
  resources :donations
  resources :comments
  root 'welcome#index'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers, :owned, :saved, :funded
    end
  end
  resources :projects do
    member do
      get :savers, :save
    end
  end
  resources :donations, only: %i[index new create show]
  resources :relationships, only: %i[create destroy]
  resources :project_relationships, only: %i[create destroy]
end
