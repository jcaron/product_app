ProductApp::Application.routes.draw do
  resources :carts

  resources :line_items

  resources :products

  root :to => "pages#home"
  match '/help', :to => "pages#help"
  match '/about', :to => "pages#about"
  match '/new', :to => "pages#new"
  match '/cart', :to => "carts#show"
  resources :categories
  resources :sub_categories
  resources :relationships, :only => [:create, :destroy]
end
