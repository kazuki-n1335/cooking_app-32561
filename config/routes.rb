Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'recipes#index'
  resources :recipes do
    resources :comments, only: :create
    resources :plans, only: [:create, :destroy, :update]
    resources :likes, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
  resources :recipe_tags, only: [:show, :index]
  resources :users, only: :show do
    resources :stocks, only: [:index, :create, :destroy, :update] do
      collection do
        post 'order'
      end
    end
    resources :shoppings, only: [:index, :create, :destroy, :update]
  end
end
