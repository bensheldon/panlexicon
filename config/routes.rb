Rails.application.routes.draw do
  devise_for :users, path: 'account'

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

  get 'account/confirmation/new', to: 'confirmations#new'
  post 'account/confirmation/new', to: 'confirmations#create'
  get 'account/confirmation', to: 'confirmations#show'

  resources :user_search_records

  get 'search/:query' => 'search#search'
  get 'search' => 'search#search'
  post 'search' => 'search#redirect_post'

  resources :daily_histories, path: 'history', as: :histories
  scope 'account' do
    resources :daily_histories, path: 'history', as: :account_histories, account: true
  end

  resource :about, only: [:show]
end

# 404 catch all route
# https://github.com/rails/rails/issues/671#issuecomment-1780159
Rails.application.config.after_initialize do |app|
  app.routes.append { match '*path', via: [:get, :post], to: 'application#render_404' } unless Rails.application.config.consider_all_requests_local
end
