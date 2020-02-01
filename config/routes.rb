Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :merchants, param: :slug, only: [:index, :show] do
        resources :items, only: [:index], action: 'service'
        resources :invoices, only: [:index], action: 'service'
        get '/revenue', to: 'merchant_solo#revenue'
        get '/favorite_customer', to: 'merchant_solo#customer'
      end

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
        resources :merchant, only: [:index], controller: 'merchants', action: 'service'
        get '/best_day', to: 'item_solo#best_day'
      end

      resources :transactions, param: :slug, only: [:index, :show] do
        resources :invoice, only: [:index], controller: 'invoices', action: 'service'
      end

      resources :customers, param: :slug, only: [:index, :show] do
        resources :invoices, only: [:index], action: 'service'
        resources :transactions, only: [:index], action: 'service'
      end
    end
  end
end
