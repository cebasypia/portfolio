Rails.application.routes.draw do
  root to: 'top#top'

  # APIコントローラへのルーティング
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :users, only: [:index, :show]
      get '/tweets/index', controller: 'tweets', action: 'index'
      get '/tweets/search', controller: 'tweets', action: 'search'
      get '/tweets/user/:id', controller: 'tweets', action: 'user'
      get '/tweets/:id', controller: 'tweets', action: 'show'
      # post  '/users', controller: 'users/registrations', action: 'create'
    end
  end
end
