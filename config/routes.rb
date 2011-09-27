Notes::Application.routes.draw do

  resources :users
  match "/signup", :to => "Users#new"
  
  get "pages/home"
  root :to => "Pages#home"
  
end
