Rails.application.routes.draw do
  devise_for :users
  get 'pages/home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "pages#home"

  # profile routes
  get "/profiles", to: "profiles#index", as: "profiles"
  post "/profiles", to: "profiles#create"
  get "/profiles/new", to: "profiles#new", as: "new_profile"
  get "/profiles/:id", to: "profiles#show", as: "profile"
  patch "/profiles/:id", to: "profiles#update"
  put "/profiles/:id", to: "profiles#update"
  get "/profiles/:id/edit", to: "profiles#edit", as: "edit_profile"
end
