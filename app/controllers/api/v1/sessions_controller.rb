class Api::V1::SessionsController < ApiController
  before_action :authenticate_user, only: [:destroy]

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      log_in user
      render json: user
    else
      # エラーメッセージを作成する
      render json: { errors: ["Invalid email/password combination"] }, status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    head :no_content
  end

  def get_auth
    render json: { current_user: current_user, logged_in: !!current_user }
  end
end
