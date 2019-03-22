Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index'
  resources :users do
    resources :identifies, only: :index
    resources :profiles, only: :index
    resources :cards, only: :index
    collection do
      get 'logout'
    end
  end

  resources :products, only:[:show, :index, :create] do
    resources :transactions, only: :index
  end

  resources :sells
end
