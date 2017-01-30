Rails.application.routes.draw do
  root 'payments#index'
  resources :members
  resources :payments
  resources :plots
  resource :config

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
