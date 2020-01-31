Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :merchants, param: :slug, only: [:index, :show] do
        resources :items, only: [:index], action: 'service'
        resources :invoices, only: [:index], action: 'service'
      end

      get 'merchants/random', to: 'merchants#show'
      get 'merchants/revenue', to: 'merchants#show'
      get 'merchants/most_revenue', to: 'merchants#show'

      resources :invoices, param: :slug, only: [:index, :show] do
        resources :transactions, only: [:index], action: 'service'
        resources :invoice_items, only: [:index], action: 'service'
        resources :items, only: [:index], action: 'service'
        resources :customer, only: [:index], controller: 'customers', action: 'service'
        resources :merchant, only: [:index], controller: 'merchants', action: 'service'
      end

      resources :invoice_items, param: :slug, only: [:index, :show] do
        resources :invoice, only: [:index], controller: 'invoices', action: 'service'
        resources :item, only: [:index], controller: 'items', action: 'service'
      end

      resources :items, param: :slug, only: [:index, :show] do
        resources :invoice_items, only: [:index], action: 'service'
        resources :merchant, only: [:index], action: 'service'
      end

      resources :transactions, param: :slug, only: [:index, :show] do
        resources :invoice, only: [:index], action: 'service'
      end

      resources :customers, param: :slug, only: [:index, :show] do
        resources :invoices, only: [:index], action: 'service'
        resources :transactions, only: [:index], action: 'service'
      end
    end
  end
end
