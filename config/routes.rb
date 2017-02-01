Rails.application.routes.draw do
  root 'payments#index'
  resources :members, except: :show
  resources :payments
  resources :plots, except: :show
  resources :dues, except: :show
  resource :setting, only: [:edit, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
