Rails.application.routes.draw do
  
  devise_for :users,
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             }

  resources :items_orders
  resources :items_menus
  resources :menus
  resources :items
  resources :orders
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
