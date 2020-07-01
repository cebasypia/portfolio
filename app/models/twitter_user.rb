class TwitterUser
  # プロパティの設定
  attr_accessor :id, :name, :screen_name, :description,
                :followers_count, :friends_count, :profile_image_url, :uri

  def initialize(args)
    @id = args[:id]
    @name = args[:name]
    @screen_name = args[:screen_name]
    @description = args[:description]
    @followers_count = args[:followers_count]
    @friends_count = args[:friends_count]
    @profile_image_url = args[:profile_image_url]
    @uri = args[:uri]
  end
end
