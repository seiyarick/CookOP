Rails.application.routes.draw do
  get 'dishes/new'
  get 'dishes/index'
  get 'dishes/edit'
  get 'dishes/show'
  get 'users/new'
  get 'users/show'
  get 'users/edit'
  get 'users/confirm'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'homes#top'
  get 'homes/about'=>'homes#about'
end
