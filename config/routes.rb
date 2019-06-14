Rails.application.routes.draw do

  root to: 'posts#index'
  get '/about' => 'static_pages#about'
  get 'posts/admin' => 'posts#admin'

  devise_for :users
  resources :genres,         only: [:create, :index, :update, :destroy]
  resources :emotions,       only: [:create, :index, :update, :destroy]
  resources :contacts,       only: [:new, :create, :show, :index, :update, :destroy]
  resources :relationships,  only: [:create, :destroy]

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :posts,      only: [:new, :create, :index, :show, :update, :destroy] do
    resource :postimages
    resource :favorites, only: [:create, :destroy]
    resource :comments,  only: [:create, :destroy]
  end
end
