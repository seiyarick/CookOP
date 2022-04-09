Rails.application.routes.draw do
  devise_for :users

  root to: 'homes#top'
  get 'homes/about'=>'homes#about'
  get 'favorites/index'
  get 'searches/new'
  get 'searches/index'
  get 'relationships/index_follow'
  get 'relationships/index_follower'
  resources :dishes, only:[:new, :index, :edit, :show, :create]
  resources :users, only:[:new, :show, :edit]

  # get 'dishes/new'
  # get 'dishes/index'
  # get 'dishes/edit'
  # get 'dishes/show'
  # get 'users/new'
  # get 'users/show'
  # get 'users/edit'
  # get 'users/confirm'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
