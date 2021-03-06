Rails.application.routes.draw do
  root to: 'top#top'

  # APIコントローラへのルーティング
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :users, only: [:show, :create]
      resource :users, only: [:update, :destroy]
      resources :reads, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
      get '/comments', to: 'comments#get_recent_comments'
      get '/comments/tweet/:id', to: 'comments#get_tweet_comments'
      get '/comments/user/:id', to: 'comments#get_user_comments'
      get '/reads', to: 'reads#get_recent_reads'
      get '/reads/tweet/:id', to: 'reads#is_read'
      get '/reads/user/:id', to: 'reads#get_user_tweets'
      post   '/login',   to: 'sessions#create'
      delete '/logout',  to: 'sessions#destroy'
      get '/auth',  to: 'sessions#get_auth'
      get '/tweets', controller: 'tweets', action: 'search'
      get '/tweets/user/:id', controller: 'tweets', action: 'user'
      get '/tweets/user/:id/recent', controller: 'tweets', action: 'user_recent_tweets'
      get '/tweets/:id', controller: 'tweets', action: 'show'
      get '/games', controller: 'games', action: 'get_score'
    end
  end
end
