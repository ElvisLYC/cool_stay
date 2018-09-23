Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get 'home/index'
  get 'listings/verify' => 'listings#verify', as: 'listing_pending_verification'
  post 'listings/:id/verify' => 'listings#verify!', as: 'verify_listing'

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

    get "users/admin"
    get "users/profile"

    get "users/:id" => 'users#profile', as: 'user_profile'
    get "users/:id/delete" => 'users#destroy', as: 'delete_user'


  # get "users/:id/deletes"
  resources :articles
  resources :listings
  resources :users

  # testing listings
  # resources :users do
  #   resources :listings
  # end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "home#index"

end
