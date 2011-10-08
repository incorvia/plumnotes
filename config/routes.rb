Notes::Application.routes.draw do

  resources :users
  resources :sessions, :only => [:new, :create, :destroy]
  resources :notecards, :only => [:create, :destroy]

  match "/signup", :to => "users#new"
  match "/signin", :to => "sessions#new"
  match '/signout', :to => "sessions#destroy"
  
  get "pages/home"
  root :to => "pages#home"
  
end
