Appa::Application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root :to => 'home#index'

  namespace :api do
    namespace :v1 do
      post "facebook_login", to: "sessions#facebook_login", as: "facebook_login"
      resources :registrations, only: [:create]
      # resources :trips, only: :update
      resources :sessions, only: :create
      get "sessions", to: "sessions#show"
      delete "sessions", to: "sessions#destroy"

      post "search", to: "search#create", as: "search"

      resources :users, only: [:show, :update, :create]

      # resources :drivers, only: [:index, :show, :update, :create] do
      #   resources :requests, only: [:create, :update]
      #   resources :driver_reviews, only: [:index, :update, :destroy, :show]
      #   put "driver_location", to: "drivers#update_location", as: "driver_location"
      #   patch "driver_location", to: "drivers#update_location"
      # end
      # post "requests/:id/driver_reviews", to: "driver_reviews#create"
      # resources :requests, only: [] do
      #   resources :driver_reviews, only: :create
      # end

      resources :trips, only: [:create, :update, :show, :index], shallow: true do
        resources :requests, only: [:create, :update]
        resources :posts, only: [:create, :update, :show] do
          resources :comments, only: [:create, :update,:destroy]
        end
      end

      post 'trips/search', to: 'trips#search', as: 'trip/search'
      
    end
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
