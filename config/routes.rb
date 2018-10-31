Rails.application.routes.draw do
  get 'braintree/new'
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get 'home/index'

  get 'listings/verify' => 'listings#verify', as: 'listing_pending_verification'
  post 'listings/:id/verify' => 'listings#verify!', as: 'verify_listing'
  post 'users/:id/delete_avatar' => 'users#delete_avatar', as: 'delete_avatar'
  post 'users/:id/upload_avatar' => 'users#upload_avatar', as: 'upload_avatar'
  post 'listings/:id/delete_photo' => 'listings#delete_photo', as: 'delete_photo'

  post 'listings/:listing_id/reservations/:id/payment' => 'braintree#checkout', as: 'checkout'
  get 'listings/:listing_id/reservations/:id/payment' => 'braintree#new', as: 'verify_payment'
  # get 'listings/:listing_id/reservations/:id/payment' => 'braintree#checkout', as: 'checkout'

  get 'users/:id/edit' => 'users#edit', as: 'edit_profile'
  get 'listings/:id/edit' => 'listings#edit', as: 'edit_listing'
  get "listings/search" => 'listings#search', as: 'listings_search'
  get "listings/global_search" => 'listings#global_search', as: 'global_search'
  get "listings/ajax_search" => 'listings#ajax_search', as: 'ajax_search'
  # get 'reservations/new'
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

    get "users/admin"
    get "users/profile"

    get "users/:id" => 'users#profile', as: 'user_profile'
    get "users/:id/delete" => 'users#destroy', as: 'delete_user'


  # get "users/:id/deletes"
  resources :articles
  resources :listings do
    # remvoed :index
    resources :reservations, only: [:index, :create, :update, :show, :delete]
  end
  resources :users

  # testing listings
  # resources :users do
  #   resources :listings
  # end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "home#index"

end
