class Api::V1::UsersController < ApiController
  before_action :set_user, only: [:show]
  before_action :set_read_tweets, only: [:show]

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def show
    render json: { user: @user, tweets: @tweets }
  end

  def create
    user = User.new(user_params)
    if user.save
      log_in user
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_read_tweets
    reads = User.find(params[:id]).reads
    @tweets = []
    reads.each do |read|
      @tweets.push(read.tweet)
    end
  end

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
