Rails.application.routes.draw do
  root 'payments#index'
  resources :members, except: :show
  resources :payments, only: [:index, :new, :create, :show] do
    member do
      patch :confirm
      get :print
    end
  end
  resources :plots, except: :show
  resources :dues, except: :show
  resource :setting, only: [:edit, :update]
  resources :transactions, except: :show

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
