Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index'
  resources :users

  get 'identify' => 'users#identify'
  get 'profile' => 'users#profile'
  get 'card' => 'users#card'
  get 'logout' => 'users#logout'
end
