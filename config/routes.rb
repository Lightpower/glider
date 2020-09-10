Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root to: 'home#index'

  resources :tasks do
  	get :finish, on: :member
  	get :delete, on: :member
  	get :postpone, on: :member
  end
end
