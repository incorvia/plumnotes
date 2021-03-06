Notes::Application.routes.draw do

  resources :users do
    resources :tags
  end
  
  resources :sessions, :only => [:new, :create, :destroy]
  resources :notecards, :only => [:create, :destroy, :edit, :update]

  match "/signup", :to => "users#new"
  match "/signin", :to => "sessions#new"
  match '/signout', :to => "sessions#destroy"
  
  get "pages/home"
  root :to => "pages#home"
  
end
