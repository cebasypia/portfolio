require 'action_view'
require 'action_view/helpers'

class Api::V1::TweetsController < ApiController
  include ActionView::Helpers::DateHelper
  def search
    @tweets = []
    since_id = nil
    client = set_client
    max_id = params[:max_id] || 0
    # リツイートを除く、検索ワードにひっかかった最新10件のツイートを取得する
    tweets = client.search(
      "#{params[:word]} #{params[:from]}",
      lang: params[:lang],
      tweet_mode: "extended",
      count: 10,
      result_type: params[:result_type],
      exclude: "retweets",
      since_id: since_id,
      max_id: max_id.to_i - 1
    )
    tweets.take(10).each do |tweet|
      @tweet = tweet.attrs
      @tweet[:id] = @tweet[:id_str]
      @tweet[:created_at] = time_ago_in_words tweet.created_at
      @tweet[:uri] = tweet.uri.to_s
      @tweet[:user][:id] = tweet.attrs[:user][:id_str]
      @tweet[:user][:profile_image_url] = tweet.user.profile_image_url_https(size = :bigger).to_s
      @tweet[:user][:user_uri] = tweet.user.uri.to_s
      @tweets.push(@tweet)
    end
    render json: @tweets.sort_by { |tweet| tweet[:id] }.reverse
  end

  def show
    client = set_client
    tweet = client.status(params[:id], tweet_mode: "extended")
    @tweet = tweet.attrs
    @tweet[:id] = @tweet[:id_str]
    @tweet[:created_at] = time_ago_in_words tweet.created_at
    @tweet[:uri] = tweet.uri.to_s
    @tweet[:user][:id] = tweet.attrs[:user][:id_str]
    @tweet[:user][:profile_image_url] = tweet.user.profile_image_url_https(size = :bigger).to_s
    @tweet[:user][:user_uri] = tweet.user.uri.to_s
    render json: @tweet
  end

  def user
    client = set_client
    user = client.user(params[:id].to_i)
    @user = TwitterUser.new(
      id: user.attrs[:id_str],
      name: user.attrs[:name],
      screen_name: user.attrs[:screen_name],
      description: user.attrs[:description],
      followers_count: user.attrs[:followers_count],
      friends_count: user.attrs[:friends_count],
      profile_image_url: user.profile_image_url_https(size = :bigger).to_s,
      uri: user.uri.to_s,
    )
    render json: @user
  end

  def user_recent_tweets
    @tweets = []
    # since_id = nil
    client = set_client
    # リツイートを除く、検索ワードにひっかかった最新10件のツイートを取得する
    tweets = client.user_timeline(
      params[:id].to_i,
      tweet_mode: "extended",
      count: 20,
      # since_id: since_id,
    )
    tweets.take(20).each do |tweet|
      @tweet = tweet.attrs
      @tweet[:id] = @tweet[:id_str]
      @tweet[:created_at] = time_ago_in_words tweet.created_at
      @tweet[:uri] = tweet.uri.to_s
      @tweet[:user][:id] = tweet.attrs[:user][:id_str]
      @tweet[:user][:profile_image_url] = tweet.user.profile_image_url_https(size = :bigger).to_s
      @tweet[:user][:user_uri] = tweet.user.uri.to_s
      @tweets.push(@tweet)
    end
    render json: @tweets.sort_by { |tweet| tweet[:id] }.reverse
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
