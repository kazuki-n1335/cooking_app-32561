Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'recipes#index'
  resources :recipes
  resources :users, only: :show do
    resources :stocks, only: [:index, :create, :destroy, :update]
    resources :shoppings, only: [:index, :create, :destroy, :update]
  end
end
