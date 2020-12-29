Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'recipes#index'
  resources :recipes, only: :index
  resources :foods, only: [:create, :new, :index, :edit, :update] do
    collection do
      get 'search'
    end
  end
  resources :users, only: :show do
    resources :stocks, only: [:index, :create, :destroy, :edit, :update]
    resources :shoppings, only: [:index, :create, :destroy, :edit, :update]
  end
end
