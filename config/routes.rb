Rails.application.routes.draw do
  get 'votes/create'
get 'votes/new'
get 'votes/show'
get 'static_pages/user'
get 'static_pages/about'
get 'static_pages/rules'
get 'home' => 'static_pages#home'
get 'points/default'
get 'points/total'
get    'login'   => 'sessions#new'
post   'login'   => 'sessions#create'
delete 'logout'  => 'sessions#destroy'
get 'users/home'
get "sign_up" => "users#new", :as => "sign_up"
root "users#new"
get 'users/rank'
get 'users/points'
get 'users/dares'
get 'users/lostest'
get 'users/issued'
resources :users do

  member do
    
    get :following, :followers
      get 'rank'
      get 'points'
      get 'dares'
      get 'lost'
      get 'issued'
      get 'home'
      get 'view'
      get 'dared'
    
resources :dares do
  member do
    resources :votes, only: [:create, :new, :show]
       
  end
end      



  end
end

  resources :posts do
    member do
  resources :comments
end

end
resources :sessions
#resources :comments
resources :points
resources :relationships,       only: [:create, :destroy]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
