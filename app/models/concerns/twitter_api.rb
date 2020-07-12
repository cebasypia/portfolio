require 'action_view'
require 'action_view/helpers'

module TwitterApi
  extend ActiveSupport::Concern

  # インスタンスメソッド
  def tweet
    client = set_client
    begin
      tweet = client.status(tweet_id, tweet_mode: "extended")
      @tweet = tweet.attrs
      @tweet[:id] = @tweet[:id_str]
      @tweet[:uri] = tweet.uri.to_s
      @tweet[:user][:id] = tweet.attrs[:user][:id_str]
      @tweet[:user][:profile_image_url] = tweet.user.profile_image_url_https(size = :bigger).to_s
      @tweet[:user][:user_uri] = tweet.user.uri.to_s
      @tweet
    rescue StandardError => error
      @tweet = { error: error }
    end
  end

  # クラスメソッド
  module ClassMethods
    include ActionView::Helpers::DateHelper

    def tweets(tweet_ids)
      client = set_client
      @tweets = []
      begin
        tweets = client.statuses(tweet_ids, tweet_mode: "extended")
        tweets.each do |tweet|
          @tweet = tweet.attrs
          @tweet[:id] = @tweet[:id_str]
          @tweet[:created_at] = time_ago_in_words tweet.created_at
          @tweet[:uri] = tweet.uri.to_s
          @tweet[:user][:id] = tweet.attrs[:user][:id_str]
          @tweet[:user][:profile_image_url] = tweet.user.profile_image_url_https(size = :bigger).to_s
          @tweet[:user][:user_uri] = tweet.user.uri.to_s
          @tweets.push(@tweet)
        end
        @tweets
      rescue StandardError => error
        @tweets.push({ error: error })
        @tweets
      end
    end

    def set_client
      client = Twitter::REST::Client.new do |config|
        # 事前準備で取得したキーのセット
        config.consumer_key         = ENV['CONSUMER_KEY']
        config.consumer_secret      = ENV['CONSUMER_SECRET']
        config.access_token         = ENV['ACCESS_TOKEN']
        config.access_token_secret  = ENV['ACCESS_TOKEN_SECRET']
      end
      client
    end
  end

  private

  def set_client
    client = Twitter::REST::Client.new do |config|
      # 事前準備で取得したキーのセット
      config.consumer_key         = ENV['CONSUMER_KEY']
      config.consumer_secret      = ENV['CONSUMER_SECRET']
      config.access_token         = ENV['ACCESS_TOKEN']
      config.access_token_secret  = ENV['ACCESS_TOKEN_SECRET']
    end
    client
  end
end
