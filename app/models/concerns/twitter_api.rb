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
  # module ClassMethods
  #   def say_today
  #     puts Time.zone.now
  #   end
  # end

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
