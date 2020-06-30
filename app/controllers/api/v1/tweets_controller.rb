class Api::V1::TweetsController < ApiController
  def index
    client = Twitter::REST::Client.new do |config|
      # 事前準備で取得したキーのセット
      config.consumer_key         = ENV['CONSUMER_KEY']
      config.consumer_secret      = ENV['CONSUMER_SECRET']
      config.access_token         = ENV['ACCESS_TOKEN']
      config.access_token_secret  = ENV['ACCESS_TOKEN_SECRET']
    end

    @tweets = []
    since_id = nil
    # リツイートを除く、検索ワードにひっかかった最新10件のツイートを取得する
    tweets = client.search("japan",
                           lang: "en",
                           tweet_mode: "extended",
                           count: 10,
                           result_type: "recent",
                           exclude: "retweets",
                           since_id: since_id)
    # 取得したツイートをモデルに渡す
    tweets.take(10).each do |tweet|
      @tweets.push(tweet)
    end
    render json: @tweets
  end

  def search
  end
end
