Rails.application.routes.draw do
  devise_for :users,
                controllers: {
                  sessions: 'sessions',
                  registrations: 'registrations'
                }
  namespace :api, defaults: { format: :json } do
    namespace :v1, defaults: { format: :json } do
      
      
      # customer routes
      get '/chefs/:id/menu', to: 'menus#show_current_menu', as: 'current_menu'

      post '/chefs/:id/orders', to: 'orders#create', as: 'new_order'

      get '/customers/:id/orders', to: 'orders#index_customer', as: 'customer_orders'

      # shared routes
      get '/orders/:order_id', to: 'orders#show', as: 'order'
      patch '/orders/:order_id', to: 'orders#update', as: 'update_order'
      get '/orders', to: 'orders#index', as: 'orders'

      # chef routes
      get '/customers', to: 'users#index', as: 'customers'

      get '/menus', to: 'menus#index', as: 'menus'
      get '/menus/:id', to: 'menus#show', as: 'menu'
      get '/items', to: 'items#index', as: 'chef_items'
      get '/items/:id', to: 'items#show', as: 'item'

      patch '/menus/:id', to: 'menus#update', as: 'update_menu'
      patch '/items/:id', to: 'items#update', as: 'update_item'

      post '/chefs/:id/menus', to: 'menus#create', as: 'create_chef_menu'
      post '/chefs/:id/items', to: 'items#create', as: 'create_chef_item'

      delete '/menus/:id', to: 'menus#destroy', as: 'destroy_menu'
      delete '/items/:id', to: 'items#destroy', as: 'destroy_item'

      post '/chefs/:id/menu', to: 'menus#set_current_menu', as: 'set_chef_menu'

      # get '/chefs/:id/orders', to: 'orders#index', as: 'chef_orders'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
