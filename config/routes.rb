Rails.application.routes.draw do
  get 'sessions/new'

  get '/', to: 'search#search',
    as: 'search',
    constraints: -> (request) {
      query = request.query_parameters.fetch(:query, nil)
      query = request.query_parameters.fetch(:q, nil) if query.nil?
      !query.blank?
    }

  root 'search#panlexicon'

  scope controller: 'mailchimp' do
    get 'after-subscribe', action: 'after_subscribe'
    get 'after-confirm', action: 'after_confirm'
  end

  get 'account/sign_in', to: 'sessions#new', as: 'sign_in'
  post 'account/sign_in', to: 'sessions#create'
  get 'account/sign_out', to: 'sessions#destroy', as: 'sign_out'

  get 'account/confirmation/new', to: 'confirmations#new'
  post 'account/confirmation/new', to: 'confirmations#create'
  get 'account/confirmation', to: 'confirmations#show'

  resources :user_search_records

  get 'search/:query' => 'search#search'
  get 'search' => 'search#search'
  post 'search' => 'search#redirect_post'

  get 'history(/:datestring)' => 'history#index', as: :history

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
