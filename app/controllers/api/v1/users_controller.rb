class Api::V1::UsersController < ApiController
  before_action :set_user, only: [:show]

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def show
    render json: @user
  end

  def create
    user = User.new(user_params)
    user.image_url = get_gravatar_url(user_params[:email])
    if user.save
      log_in user
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if user_params[:email]
      current_user.image_url = get_gravatar_url(user_params[:email])
    end
    if current_user.update(user_update_params)
      render json: current_user, status: :ok
    else
      render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def user_update_params
    params.permit(:name, :email, :profile)
  end

  def get_gravatar_url(email)
    gravatar_id = Digest::MD5.hexdigest(email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
  end
end
