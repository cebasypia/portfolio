class Tweet
  # プロパティの設定
  attr_accessor :id, :text, :full_text, :favorite_count, :retweet_count, :uri, :created_at,
                :user_id, :user_name, :user_profile_image_url, :user_uri

  def initialize(args)
    @id = args[:id]
    @full_text = args[:full_text]
    @favorite_count = args[:favorite_count]
    @retweet_count = args[:retweet_count]
    @uri = args[:uri]
    @created_at = args[:created_at]
    @user_id = args[:user_id]
    @user_name = args[:user_name]
    @user_profile_image_url = args[:user_profile_image_url]
    @user_uri = args[:user_uri]
  end
end
