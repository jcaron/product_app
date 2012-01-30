ProductApp::Application.routes.draw do
  root :to => "pages#home"
  match '/help', :to => "pages#help"
  match '/about', :to => "pages#about"
  match '/new', :to => "pages#new"

  resources :categories
  resources :sub_categories
end
