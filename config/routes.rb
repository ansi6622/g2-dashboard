Rails.application.routes.draw do
  root 'welcome#index'

  resources :users
  resources :projects do
    resources :memberships
  end  

  get '/logout' => 'sessions#destroy', :as => 'logout'
  get '/login' => 'sessions#new', :as => 'login'
  post '/login' => 'sessions#create'
  get '/terms' => 'terms#index', :as => 'terms'
  get '/about' => 'about#index', :as => 'about'
  get '/settings' => 'settings#index', :as => 'settings'
  get '/projects/:project_id/events' => 'events#show'


end
