Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      get 'merchants/find', to: 'merchants#show'
      get 'merchants/find_all', to: 'merchants#show'
      get 'merchants/random', to: 'merchants#show'
    end
  end

end
