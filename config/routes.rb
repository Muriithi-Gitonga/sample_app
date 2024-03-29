Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root  'static_pages#home'
  get   '/signup',  to: 'users#new'
  get   "/about",   to: "static_pages#about"
  get   "/contact", to: "static_pages#contact"
  get   '/help',    to: 'static_pages#help'
  get   '/login',   to: "sessions#new"
  post   '/login',  to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  resources :users, only: [:index, :show, :edit, :create, :update, :destroy ]
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
