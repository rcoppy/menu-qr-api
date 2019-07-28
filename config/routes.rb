Rails.application.routes.draw do

  get 'api/v1/owner/user', to: 'api/v1/owner/users#show', as: 'owner_user'
  get 'api/v1/customer/user', to: 'api/v1/customer/users#show', as: 'customer_user'
  
  devise_for :users,
                controllers: {
                  sessions: 'sessions',
                  registrations: 'registrations'
                }
  namespace :api, defaults: { format: :json } do
    namespace :v1, defaults: { format: :json } do
      namespace :customer, defaults: { format: :json } do
        # customer routes
        post '/restaurants/:id/orders', to: 'orders#create', as: 'new_order'
        # customers can become owners through owner app/owner api restaurants#create
        get '/orders/:order_id', to: '/orders#show', as: 'customer_order'
        get '/orders', to: '/orders#index', as: 'customer_orders'
        get '/restaurants/:id', to: 'restaurants#show', as: 'restaurant'
        get '/restaurants', to: '/restaurants#index', as: 'nearby_restaurants'
        patch '/orders/:order_id', to: '/orders#update', as: 'update_customer_order'
      end

      # shared
      namespace :shared, defaults: { format: :json } do
        get '/restaurants/:id/items', to: 'items#index', as: 'restaurant_items'
        get '/items/:id', to: 'items#show', as: 'restaurant_item'
      end

      namespace :owner, defaults: { format: :json } do
        # owner routes
        get '/customers', to: 'users#index', as: 'customers'

        get '/items', to: 'items#index', as: 'owner_items'
        get '/items/:id', to: 'items#show', as: 'owner_item'

        get '/restaurants/:id', to: 'restaurants#show', as: 'owner_restaurant'
        get '/restaurants', to: 'restaurants#index', as: 'owner_restaurants'
        get '/orders/:id', to: 'orders#show', as: 'restaurant_order'
        get '/restaurants/:id/orders', to: 'orders#index', as: 'restaurant_orders'

        patch '/items/:id', to: 'items#update', as: 'update_item'
        patch '/restaurants/:id', to: 'restaurants#update', as: 'update_restaurant'
        patch '/orders/:id', to: 'orders#update', as: 'update_restaurant_order'

        post '/restaurants', to: 'restaurants#create', as: 'new_owner_restaurant'
        post '/restaurants/:id/items', to: 'items#create', as: 'new_restaurant_item'

        # delete '/items/:id', to: 'items#destroy', as: 'destroy_item'
        # instead of deleting items (which can break existing orders), set an item to not visible
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
