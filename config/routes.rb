Rails.application.routes.draw do
  # page routes
  get 'pages/home'
  root to: "pages#home"

  # crawl routes
  resources :crawls

  # location routes
  resources :locations
  devise_for :users, controllers: { registrations: "registrations" }

  # attendee routes
  post "/attendees", to: "attendees#create", as: "attendees"

  # profile routes
  get "/profiles", to: "profiles#index", as: "profiles"
  post "/profiles", to: "profiles#create"
  get "/profiles/new", to: "profiles#new", as: "new_profile"
  get "/profiles/:id", to: "profiles#show", as: "profile"
  patch "/profiles/:id", to: "profiles#update"
  put "/profiles/:id", to: "profiles#update"
  get "/profiles/:id/edit", to: "profiles#edit", as: "edit_profile"
end
