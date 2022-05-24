Rails.application.routes.draw do
  devise_for :users

  root to: 'homes#top'
  get 'users/confirm' => 'users#confirm'
  get 'dishes/search' => 'dishes#search'
  get 'dishes/ranking' => 'dishes#ranking'
  patch 'users/update_delete' => 'users#update_delete'
  delete 'notifications/destroy_all' => 'notifications#destroy_all'
  post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
  
  resources :dishes, only:[:new, :index, :edit, :show, :create, :update, :destroy, :search] do
   resource :favorites, only:[:create, :destroy]
   resources :comments, only:[:create, :destroy]
  end

  resources :users, only:[:new, :show, :edit, :update, :index] do
   resource :relationships, only: [:create, :destroy]
   get :followings, on: :member
   get :followers, on: :member
  end

  resources :notifications, only:[:index]

end
