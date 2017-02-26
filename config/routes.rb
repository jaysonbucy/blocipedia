Rails.application.routes.draw do
  devise_for :users

  resources :wikis
  resources :charges, only: [:new, :create]

  root 'wikis#index'

  delete '/users/:id/downgrade', to: 'users#downgrade', as: :user_downgrade
  # namespace :user do
  #   root 'wikis#index'
  # end
end
