Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
        resources :invoices, only: [:index]
      end

      get 'merchants/find', to: 'merchants#show'
      get 'merchants/find_all', to: 'merchants#show'
      get 'merchants/random', to: 'merchants#show'

      resources :invoices, only: [] do
        resources :transactions, only: [:index]
        resources :invoice_items, only: [:index]
        resources :items, only: [:index]
        resources :customer, only: [:index]
        resources :merchant, only: [:index]
      end

      resources :invoice_items, only: [] do
        resources :invoice, only: [:index]
        resources :items, only: [:index]
      end

      resources :items, only: [] do
        resources :invoice_items, only: [:index]
        resources :merchant, only: [:index]
      end

      resources :transactions, only: [] do
        resources :invoice, only: [:index]
      end

      resources :customers, only: [] do
        resources :invoices, only: [:index]
        resources :transactions, only: [:index]
      end
    end
  end
end
