Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get "home/about" => "homes#about"
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:new, :index, :show, :edit, :update] do
    resources :relationships, only: [:create]
  end
  
  delete "/users/:user_id/relationships" => "relationships#destroy", as: "user_relationship"
  
  resources :users do
    member do
      get :following, :followers
    end
  end
  
end
