Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations',omniauth_callbacks: 'users/omniauth_callbacks'},
  skip: [ :registrations]
  as :user do
    get 'signup' => 'users/registrations#signup'
    get "/signup/registration" => "users/registrations#registration", as: :new_user_registration
    get "/signup/google" => "users/registrations#google"
    post "signup/sms_confirmation" => "users/registrations#sms_confirmation"
    post "signup/address" => "users/registrations#address"
    post "signup/credit" => "users/registrations#credit"
    post "/signup/completed" => "users/registrations#create"
    get "/signup/done" => "users/registrations#done"
  end

  root 'products#index'
  resources :identifies, only: [:index, :update]
  resources :profiles, only: [:index] do
    collection do
      patch 'save'
    end
  end

  resources :users do
    resources :cards, only:[:index, :new, :update, :create]

    collection do
      delete '/:user_id/card/destroy' => "cards#destroy", as: :card_delete
    end

    collection do
      get 'logout'
      get '/listings/listing' => 'users#listing'
      get '/listings/completed' => 'users#completed'
      get '/listings/in_progress' => 'users#in_progress'
    end
  end

  resources :products do
    collection do
      get "/:product_id/rate" => "purchase#edit", as: :rate
      patch "/:product_id/rate" => "purchase#update", as: :rate_update
    end

    collection do
      patch "/:id/switch" => "products#switch", as: :switch
    end

    resources :transactions, only: :index

    collection do
      post "/:products_id/transactions" => "cards#pay", as: :buy_product
    end

    resources :comments, only: :create
  end

  resources :sells
  resources :search, only: :index
  resources :categories, only: :show

  resources :brands, only: :new

  delete '/products/:id/edit' => 'products#remove'


end
