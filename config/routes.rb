Rails.application.routes.draw do

  # resources :friendships, only: [:create]
  get 'friendships/re_create'
  get 'friendships/create'
  get 'friendships/destroy'
  get 'friendships/update'
  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
