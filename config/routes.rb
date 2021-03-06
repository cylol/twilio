Rails.application.routes.draw do

  root to: 'appointmentreminder#index'
  get 'appointmentreminder/index'
  get 'appointmentreminder/makecall'
  get 'appointmentreminder/reminder'
  get 'appointmentreminder/directions'
  get 'appointmentreminder/goodbye'
  get 'appointmentreminder/list'
  get 'appointmentreminder/ok'
  get 'appointmentreminder/order'


  post 'appointmentreminder/index'
  post 'appointmentreminder/makecall'
  post 'appointmentreminder/reminder'
  post 'appointmentreminder/directions'
  post 'appointmentreminder/goodbye'
  post 'appointmentreminder/list'
  post 'appointmentreminder/ok'
  post 'appointmentreminder/order'



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

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
