Rails.application.routes.draw do
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
end
