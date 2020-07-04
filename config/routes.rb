Rails.application.routes.draw do
  root to: 'top#top'

  # APIコントローラへのルーティング
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :users, only: [:show, :create, :update, :destroy]
      post   '/login',   to: 'sessions#create'
      delete '/logout',  to: 'sessions#destroy'
      get '/logged_in',  to: 'sessions#logged_in'
      post '/tweets', controller: 'tweets', action: 'search'
      get '/tweets/user/:id', controller: 'tweets', action: 'user'
      get '/tweets/:id', controller: 'tweets', action: 'show'
    end
  end
end
