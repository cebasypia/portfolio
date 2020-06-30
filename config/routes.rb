Rails.application.routes.draw do
  root to: 'top#top'

  # APIコントローラへのルーティング
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :users, only: [:index, :show]
      get '/tweets/index', controller: 'tweets', action: 'index'
      # post  '/users', controller: 'users/registrations', action: 'create'
    end
  end
end
