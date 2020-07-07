class Comment < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { maximum: 140 }

  def tweet
    client = set_client
    tweet = client.status(tweet_id, tweet_mode: "extended")
    @tweet = Tweet.new(
      id: tweet.attrs[:id_str],
      full_text: tweet.attrs[:full_text],
      favorite_count: tweet.attrs[:favorite_count],
      retweet_count: tweet.attrs[:retweet_count],
      created_at: tweet.attrs[:created_at],
      uri: tweet.uri.to_s,
      user_id: tweet.user.attrs[:id_str],
      user_name: tweet.user.attrs[:name],
      user_profile_image_url: tweet.user.profile_image_url_https(size = :bigger).to_s,
      user_uri: tweet.user.uri .to_s
    )
    @tweet
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
