Rails.application.routes.draw do
  root 'welcome#index'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, except: [:index] do
    member do
      get :following, :followers, :owned, :saved, :funded
    end
  end
  resources :projects do
    member do
      get :savers, :save, :forget
    end
  end
  get '/search', to: 'projects#search'
  resources :donations, only: %i[new create]
  resources :relationships, only: %i[create destroy]
  resources :project_relationships, only: %i[create destroy]
  resources :comments, only: %i[index new create show]

  get '*path' => redirect('/')
end
