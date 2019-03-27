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
  resources :users do
    resources :identifies, only: :index
    resources :profiles, only: :index
    resources :cards, only: :index
    collection do
      get 'logout'
    end
  end

  resources :products, only:[:show, :index, :create, :new] do
    resources :transactions, only: :index
  end

  resources :sells
  get '/categories' => 'categories#category'
end
