Notes::Application.routes.draw do
  get "pages/home"
  get "pages/signup"
  
  match "/signup", :to => "Pages#signup"
  root :to => "Pages#home"
  
end
