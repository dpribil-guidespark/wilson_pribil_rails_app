Rails.application.routes.draw do

  get 'home', to: 'static_pages#home'

  get 'about', to: 'static_pages#about'

  get 'leaderboard', to: 'static_pages#leaderboard'

  get 'challenges/latest', to: 'challenges#latest_challenge'

  put 'guesses/update_guess_status', to: 'guesses#update_guess_status', as: 'update_guess_status'
  post 'challenges/create', to: 'challenges#create', as: 'create_challenge'

  resources :users do
    get :autocomplete_user_first_name, :on => :collection
    get :autocomplete_user_last_name, :on => :collection
  end

  resources :challenges do
    resources :guesses
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
    root 'static_pages#home'
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
