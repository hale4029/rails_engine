Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :merchants, param: :slug, only: [:index, :show] do
        resources :items, :name_prefix => 'service'
        resources :invoices, :name_prefix => 'service'
      end

      get 'merchants/random', to: 'merchants#show'
      get 'merchants/revenue', to: 'merchants#show'
      get 'merchants/most_revenue', to: 'merchants#show'

      resources :invoices, param: :slug, only: [:index, :show] do
        resources :transactions, only: [:index]
        resources :invoice_items, only: [:index]
        resources :items, only: [:index]
        resources :customer, only: [:index]
        resources :merchant, only: [:index]
      end

      resources :invoice_items, param: :slug, only: [:index, :show] do
        resources :invoice, only: [:index]
        resources :items, only: [:index]
      end

      resources :items, param: :slug, only: [:index, :show] do
        resources :invoice_items, only: [:index]
        resources :merchant, only: [:index]
      end

      resources :transactions, only: [:index, :show] do
        resources :invoice, only: [:index]
      end

      resources :customers, param: :slug, only: [:index, :show] do
        resources :invoices, only: [:index]
        resources :transactions, only: [:index]
      end
    end
  end
end
